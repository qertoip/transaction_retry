# transaction_retry

Retries database transaction on deadlock and transaction serialization errors. Supports MySQL, PostgreSQL, and SQLite.

## Example

The gem works automatically by rescuing ActiveRecord::TransactionIsolationConflict and retrying the transaction.

## Installation

Add this to your Gemfile:

    gem 'transaction_retry'

Then run:

    bundle

__With Rails it works out of the box__.

If you have a standalone ActiveRecord-based project you'll need to call:

    TransactionRetry.apply_activerecord_patch     # after connecting to the database

__after__ connecting to the database.

## Configuration

You can optionally configure transaction_retry gem in your config/initializers/transaction_retry.rb (or anywhere else):

    TransactionRetry.max_retries = 3
    TransactionRetry.wait_times = [0, 1, 2, 4, 8, 16, 32]   # seconds to sleep after retry n

## Features

 * Supports MySQL, PostgreSQL, and SQLite (as long as you are using new drivers mysql2, pg, sqlite3).
 * Exponential sleep times between retries (0, 1, 2, 4 seconds).
 * Logs every retry as a warning.
 * Intentionally does not retry nested transactions.
 * Configurable number of retries and sleep time between them.
 * Use it in your Rails application or a standalone ActiveRecord-based project.

## Requirements

 * ruby 1.9.2
 * activerecord 3.0.11+

## Running tests

Run tests on the selected database (mysql2 by default):

    db=mysql2 bundle exec rake test
    db=postgresql bundle exec rake test
    db=sqlite3 bundle exec rake test

Run tests on all supported databases:

    ./tests

Database configuration is hardcoded in test/db/db.rb; feel free to improve this and submit a pull request.

## How intrusive is this gem?

You should be very suspicious about any gem that monkey patches your stock Ruby on Rails framework.

This gem is carefully written to not be more intrusive than it needs to be:

 * wraps ActiveRecord::Base#transaction class method using alias_method to add new behaviour
 * introduces two new private class methods in ActiveRecord::Base (with names that should never collide)

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.