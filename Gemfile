source "http://rubygems.org"

# Specify your gem's dependencies in kontolib.gemspec
gemspec

group :test do
  # Use the gem instead of a dated version bundled with Ruby
  gem 'minitest'

  gem 'simplecov', :require => false

  gem 'mysql2'
  gem 'pg'
  gem 'sqlite3'
end

group :development do
  gem 'rake'
  # enhance irb
  gem 'awesome_print', :require => false
  gem 'pry', :require => false
end
