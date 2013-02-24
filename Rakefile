require "bundler/gem_tasks"

require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_spec.rb'
end
task :spec

Cucumber::Rake::Task.new(:features, "Run all features") do |t|
  t.profile = 'focus'
end

desc 'Run all specs and features'
task :test => %w[spec features]

task :default => :test

