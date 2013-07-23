require "test_helper"

class SettingsFeature < FeatureTest
  
  def setup
    super
    log_in_user
    @organization = FactoryGirl.create(:organization)
    @organization.users << @user
  end
  
  def test_user_views_settings
    visit dashboard_path
    find("img.menu").click
    click_link "Settings"
    assert_includes find("h1").text, "Your Settings"
  end
  
  def test_user_toggles_order_email_notifications
    visit settings_path
    assert has_checked_field?("order_email_notification")
    find("#order_email_notification").click
    click_button "Update Preferences"
    assert_includes page.text, "Settings updated."
    refute has_checked_field?("order_email_notification")
  end

end