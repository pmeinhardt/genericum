require "rubygems"
require "bundler/setup"

require "sinatra/activerecord/rake"
require "rspec/core/rake_task"

# The :environment task loads the application, models etc.
# Require it whenever you need to work with application classes.

task :environment do
  require "./application"
end

# Scraping tasks gather information from various data sources.
# Run via `cron` or invoke them manually.

namespace :scrape do
  desc "Scrape data from all sources."
  task :all => ["gelbe-liste"]

  task "gelbe-liste" => :environment do
    Sources::GelbeListe.scrape
  end

  task :default => :all
end

# Database-management tasks from Sinatra ActiveRecord –
# we just require the environment before each of them.

%w[
  db:create_migration
  db:migrate
  db:rollback
  db:schema:dump
  db:schema:load
].each do |t|
  original = Rake::Task[t]
  original.enhance([:environment])
end

# Test-related tasks.

RSpec::Core::RakeTask.new(:spec)
task :spec => :environment

# Define a default task.

task :default => :spec
