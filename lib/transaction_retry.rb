require "active_record"
require "transaction_isolation"
require_relative "transaction_retry/version"

module TransactionRetry

  # Must be called after ActiveRecord established a connection.
  # Only then we know which connection adapter is actually loaded and can be enhanced.
  # Please note ActiveRecord does not load unused adapters.
  def self.apply_activerecord_patch
    TransactionIsolation.apply_activerecord_patch
    require_relative 'transaction_retry/active_record/base'
  end

  if defined?( ::Rails )
    # Setup applying the patch after Rails is initialized.
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        TransactionRetry.apply_activerecord_patch
      end
    end
  end

  def self.before_retry=(lambda_block)
    @@before_retry = lambda_block
  end

  def self.before_retry
    @@before_retry ||= nil
  end

  def self.retry_on=(error_classes)
    @@retry_on = Array(error_classes)
  end

  def self.retry_on
    @@retry_on ||= []
  end

  def self.max_retries
    @@max_retries ||= 3
  end

  def self.max_retries=( n )
    @@max_retries = n
  end

  def self.wait_times
    @@wait_times ||= [0, 1, 2, 4, 8, 16, 32]
  end

  def self.wait_times=( array_of_seconds )
    @@wait_times = array_of_seconds
  end

  def self.fuzz
    @@fuzz ||= true
  end

  def self.fuzz=( val )
    @@fuzz = val
  end

end
