ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require File.expand_path("../../app/helpers/application_helper.rb", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require "capybara/poltergeist"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation
Capybara.default_driver = :poltergeist

# save_and_open_page
# page.save_screenshot('screenshot.png')

class FeatureTest < Minitest::Test
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include ApplicationHelper
  include Sorcery::TestHelpers::Rails
  Gofer::Application.load_tasks
  # register_spec_type(//, self)
  
  def setup
    Rake::Task["db:seed"].tap(&:reenable).invoke
  end
  
  def teardown
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
  
end

class String
  def title_case
    upcase
  end
end
