ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require File.expand_path("../../app/helpers/application_helper.rb", __FILE__)
require "minitest/autorun"
require "minitest/pride"
require "capybara/rails"
require "capybara/poltergeist"
require "database_cleaner"
require "helpers"

# Some helpers:
# save_and_open_page
# page.save_screenshot('screenshot.png')

class FeatureTest < Minitest::Test
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include ApplicationHelper
  include SessionHelpers
  
  DatabaseCleaner.strategy = :truncation
  Capybara.default_driver = :poltergeist
  Gofer::Application.load_tasks
  
  Rake::Task["db:test:prepare"].invoke
  
  def setup
    # Rake::Task["db:seed"].tap(&:reenable).invoke
    @user = FactoryGirl.create(:user)
    @user.set_default_preferences
  end
  
  def teardown
    Capybara.reset_sessions!
    DatabaseCleaner.clean
    ActionMailer::Base.deliveries.clear
  end
  
end

class String
  def title_case
    upcase
  end
end
