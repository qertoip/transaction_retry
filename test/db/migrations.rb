module TransactionRetry
  module Test
    module Migrations

      def self.run!
        c = ::ActiveRecord::Base.connection

        # Queued Jobs
        
        c.create_table "queued_jobs", :force => true do |t|
          t.text     "job",                               :null => false
          t.integer  "status",     :default => 0,         :null => false
          t.timestamps
        end

      end

    end
  end
end
