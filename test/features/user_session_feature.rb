require "test_helper"

class UserSessionFeature < FeatureTest
  
  def test_user_logging_in
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    assert_equal dashboard_path, current_path
    assert_includes page.text, "Welcome back, #{@user.first_name}."
  end
  
  def test_user_logging_in_with_invalid_credentials
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "asdf"
    click_button "Log In"
    refute_equal dashboard_path, current_path
    assert_includes page.text, "Login failed"
  end
  
  def test_user_logging_out
    test_user_logging_in
    visit log_out_path
    assert_equal log_in_path, current_path
    assert_includes page.text, "Later, #{@user.first_name}."
  end
  
  def test_user_forgot_password
    visit log_in_path
    click_link "Forgot password?"
    fill_in "username", with: "test@example.com"
    click_button "Reset Password"
    mail = ActionMailer::Base.deliveries.last
    assert_equal @user.email, mail.to[0]
    assert_includes page.text, "Instructions have been sent to your email."
  end
  
  def test_user_resets_password
    test_user_forgot_password
    reset_path = ActionMailer::Base.deliveries.last.body.to_s.split("\n").last.gsub(/http:\/\/localhost/, "")
    visit reset_path
    fill_in "user[password]", with: "asdf"
    fill_in "user[password_confirmation]", with: "asdf"
    click_button "Reset Password"
    assert_includes page.text, "Your password was successfully updated."
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "asdf"
    click_button "Log In"
    assert_equal dashboard_path, current_path
  end
  
end
