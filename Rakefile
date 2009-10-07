require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the xss-shield plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'xss_shield'
    gemspec.summary = 'Protect your Rails site from XSS attacks.'
    gemspec.description = 'This Rails plugin provides automatic cross site ' +
      'scripting (XSS) protection for your views. Once installed, you no ' +
      'longer have to manually and painstakingly sanitize all your views ' +
      'with HTML escaping.'
    gemspec.email = 'jamestyj@gmail.com'
    gemspec.homepage = 'http://github.com/jamestyj/xss_shield'
    gemspec.authors = [ 'James Tan' ]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install " +
       "technicalpickles-jeweler -s http://gems.github.com"
end

