require 'active_record/base'

module TransactionRetry
  module ActiveRecord
    module Base

      def self.included( base )
        base.extend( ClassMethods )
        base.class_eval do
          class << self
            alias_method :transaction_without_retry, :transaction
            alias_method :transaction, :transaction_with_retry
          end
        end
      end
      
      module ClassMethods
        
        def transaction_with_retry(*objects, &block)
          retry_count = 0

          begin
            transaction_without_retry(*objects, &block)
          rescue ::ActiveRecord::TransactionIsolationConflict
            raise if retry_count >= TransactionRetry.max_retries
            raise if tr_in_nested_transaction?
            
            retry_count += 1
            postfix = { 1 => 'st', 2 => 'nd', 3 => 'rd' }[retry_count] || 'th'
            logger.warn "Transaction isolation conflict detected. Retrying for the #{retry_count}-#{postfix} time..." if logger
            tr_exponential_pause( retry_count )
            retry
          end
        end
        
        private

          # Sleep 0, 1, 2, 4, ... seconds up to the TransactionRetry.max_retries.
          # Cap the sleep time at 32 seconds.
          # An ugly tr_ prefix is used to minimize the risk of method clash in the future.
          def tr_exponential_pause( count )
            seconds = TransactionRetry.wait_times[count-1] || 32
            sleep( seconds ) if seconds > 0
          end
        
          # Returns true if we are in the nested transaction (the one with :requires_new => true).
          # Returns false otherwise.
          # An ugly tr_ prefix is used to minimize the risk of method clash in the future.
          def tr_in_nested_transaction?
            connection.open_transactions != 0
          end

      end
    end
  end
end

ActiveRecord::Base.send( :include, TransactionRetry::ActiveRecord::Base )
