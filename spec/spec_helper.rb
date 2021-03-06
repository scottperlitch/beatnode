ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'factory_girl'
require 'database_cleaner'
require 'fileutils'

FactoryGirl.find_definitions

Dir[Rails.root.join('spec/support/**/*.rb')].each &method(:require)

Fog.mock!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include SessionsHelper

  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
