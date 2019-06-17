require 'fileutils'

module TransactionRetry
  module Test
    module Db

      def self.connect_to_mysql2
        ::ActiveRecord::Base.establish_connection(
          :adapter => "mysql2",
          :database => "transaction_retry_test",
          :username => ENV['DB_USERNAME'],
          :password => ENV['DB_PASSWORD']
        )
      end

      def self.connect_to_postgresql
        ::ActiveRecord::Base.establish_connection(
          :adapter => "postgresql",
          :database => "transaction_retry_test",
          :user => ENV['DB_USERNAME'],
          :password => ENV['DB_PASSWORD']
        )
      end

      def self.connect_to_sqlite3
        ActiveRecord::Base.establish_connection(
          :adapter => "sqlite3",
          :database => ":memory:",
          :verbosity => "silent"
        )
      end

    end
  end
end
