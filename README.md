# transaction_retry

Retries database transaction on deadlock and transaction serialization errors. Supports MySQL, PostgreSQL, and SQLite.

This is a forked project from [transaction_retry](https://github.com/qertoip/transaction_retry)

## Example

The gem works automatically by rescuing ActiveRecord::TransactionIsolationConflict and retrying the transaction.

## Installation

Add this to your Gemfile:

    gem 'transaction_retry', git: 'https://github.com/optimalworkshop/transaction_retry.git'

Then run:

    bundle

__It works out of the box with Ruby on Rails__.

If you have a standalone ActiveRecord-based project you'll need to call:

    TransactionRetry.apply_activerecord_patch     # after connecting to the database

__after__ connecting to the database.

## Database deadlock and serialization errors that are retried

#### MySQL

 * Deadlock found when trying to get lock
 * Lock wait timeout exceeded

#### PostgreSQL

 * deadlock detected
 * could not serialize access

#### SQLite

 * The database file is locked
 * A table in the database is locked
 * Database lock protocol error

## Configuration

You can optionally configure transaction_retry gem in your config/initializers/transaction_retry.rb (or anywhere else):

    TransactionRetry.max_retries = 3
    TransactionRetry.wait_times = [0, 1, 2, 4, 8, 16, 32]   # seconds to sleep after retry n
    TransactionRetry.retry_on = CustomErrorClass # To add another error class to retry on (ActiveRecord::TransactionIsolationConflict always included)
  or
    TransactionRetry.retry_on = [<custom error classes>]
    TransactionRetry.before_retry = ->(retry_num, error) { ... }

## Features

 * Supports MySQL, PostgreSQL, and SQLite (as long as you are using new drivers mysql2, pg, sqlite3).
 * Exponential sleep times between retries (0, 1, 2, 4 seconds).
 * Logs every retry as a warning.
 * Intentionally does not retry nested transactions.
 * Configurable number of retries and sleep time between them.
 * Configure a custom hook to run before every retry.
 * Use it in your Rails application or a standalone ActiveRecord-based project.

## Testimonials

This gem was initially developed for and successfully works in production at [Kontomierz.pl](http://kontomierz.pl) - the finest Polish personal finance app.

## Requirements

 * ruby 2.2.2+
 * activerecord 5.1+

## Running tests

Run tests on the selected database (mysql2 by default):

    db=mysql2 DB_USERNAME=<db user> DB_PASSWORD=<db password> bundle exec rake test
    db=postgresql DB_USERNAME=<db user> DB_PASSWORD=<db password> bundle exec rake test
    db=sqlite3 bundle exec rake test

Run tests on all supported databases:

    ./tests

## How intrusive is this gem?

You should be very suspicious about any gem that monkey patches your stock Ruby on Rails framework.

This gem is carefully written to not be more intrusive than it needs to be:

 * wraps ActiveRecord::Base#transaction class method using alias_method to add new behaviour
 * introduces two new private class methods in ActiveRecord::Base (with names that should never collide)

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.
