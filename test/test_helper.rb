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

class FeatureTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  Gofer::Application.load_tasks
  register_spec_type(//, self)
  
  before do
    Rake::Task["db:seed"].tap(&:reenable).invoke
  end
  after do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
end

# Turn.config.format = :outline

class String
  def title_case
    upcase
  end
end
