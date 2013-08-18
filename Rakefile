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

# Tasks to help with development.

namespace :code do
  desc "Run JSHint on JavaScript code"
  task :jshint do
    available = system("which -s jshint")
    site = "http://jshint.com/install"

    abort("Install JSHint: #{site}") unless available

    stdout = `jshint .`

    abort(stdout) unless $?.success?
  end

  desc "Run RECESS on CSS code"
  task :csshint do
    available = system("which -s recess")
    site = "http://twitter.github.io/recess/"

    abort("Install RECESS: #{site}") unless available

    stdout = `recess public/stylesheets/*.css`

    # unfortunately RECESS does not exit with a non-zero code on errors
    failed = stdout.include?("FAILURES")
    failed ||= stdout.include?("Parse error")
    failed ||= stdout.include?("Parser error")

    abort(stdout) if failed
  end
end

# Test-related tasks.

RSpec::Core::RakeTask.new(:spec)
task :spec => :environment

# Define a default task.

task :default => :spec
