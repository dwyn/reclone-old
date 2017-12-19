require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'dotenv/tasks'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task mytask: :dotenv do
    # things that require .env
    ./lib/reclone/cli.rb
end