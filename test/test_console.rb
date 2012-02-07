# Ensure that LOAD_PATH is the same as when running "rake test"; normally rake takes care of that
$LOAD_PATH << File.expand_path( ".", File.dirname( __FILE__ ) )
$LOAD_PATH << File.expand_path( "./lib", File.dirname( __FILE__ ) )
$LOAD_PATH << File.expand_path( "./test", File.dirname( __FILE__ ) )

# Boot the app
require_relative 'library_setup'

# Fire the console
require 'pry'
binding.pry
