require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs += ["test", "lib"]
  t.pattern = 'test/integration/**/*_test.rb'
  t.verbose = true
end

task :default => [:test]
