require "test_helper"

class UserSession < FeatureTest
  
  def setup
    super
    @user = FactoryGirl.create(:user)
  end
  
  def test_user_logging_in
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    assert_equal dashboard_path, current_path
  end
  
  def test_user_logging_in_with_invalid_credentials
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "asdf"
    click_button "Log In"
    refute_equal dashboard_path, current_path
  end
  
  def test_user_logging_out
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    visit log_out_path
    assert_equal log_in_path, current_path
  end
  
  def test_user_forgot_password
    visit log_in_path
    click_link "Forgot password?"
    fill_in "username", with: "test@example.com"
    click_button "Reset Password"
    mail = ActionMailer::Base.deliveries.last
    assert_equal @user.email, mail.to[0]
  end
  
end
