require "rubygems"
require "bundler/setup"

require "sinatra/activerecord/rake"
require "rspec/core/rake_task"

$:.unshift File.expand_path("../lib", __FILE__)

require "./application"

desc "Scrape data  from ..."
task :scrape do
  # TODO: Sources::GelbeListe.new
end

RSpec::Core::RakeTask.new(:spec)
