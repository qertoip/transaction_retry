# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transaction_retry/version"

Gem::Specification.new do |s|
  s.name        = "transaction_retry"
  s.version     = TransactionRetry::VERSION
  s.authors     = ["Piotr 'Qertoip' Włodarek"]
  s.email       = ["qertoip@gmail.com"]
  s.homepage    = "https://github.com/qertoip/transaction_retry"
  s.summary     = %q{Retries database transaction on deadlock and transaction serialization errors. Supports MySQL, PostgreSQL and SQLite.}
  s.description = %q{Retries database transaction on deadlock and transaction serialization errors. Supports MySQL, PostgreSQL and SQLite (as long as you are using new drivers mysql2, pg, sqlite3).}
  s.required_ruby_version = '>= 1.9.2'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activerecord", ">= 3.0.11"
  s.add_runtime_dependency "transaction_isolation", ">= 1.0.2"
end