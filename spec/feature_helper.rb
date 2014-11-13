require 'rails_helper'
require 'capybara/rspec'
require 'rack_session_access/capybara'

RSpec.configure do |config|
  config.include FixtureMethods

  config.before(:each) do
    Capybara.reset!
  end
end
