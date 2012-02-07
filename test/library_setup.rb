# Prepares application to be tested (requires files, connects to db, resets schema and data, applies patches, etc.)

# Initialize database
require 'db/all'

case ENV['db']
  when 'mysql2'
    TransactionRetry::Test::Db.connect_to_mysql2
  when 'postgresql'
    TransactionRetry::Test::Db.connect_to_postgresql
  when 'sqlite3'
    TransactionRetry::Test::Db.connect_to_sqlite3
  else
    TransactionRetry::Test::Db.connect_to_mysql2
end

require 'logger'
ActiveRecord::Base.logger = Logger.new( File.expand_path( "#{File.dirname( __FILE__ )}/log/test.log" ) )

TransactionRetry::Test::Migrations.run!

# Load the code that will be tested
require 'transaction_retry'

TransactionRetry.apply_activerecord_patch
