require "rspec"
require "rack/test"

ENV["RACK_ENV"] = "test"

require File.expand_path("../../application", __FILE__)

ActiveRecord::Base.logger.level = Logger::FATAL
ActiveRecord::Base.default_timezone = "UTC"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
