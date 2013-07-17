require "test_helper"

describe "User Session" do
  include ApplicationHelper
  
  before do
    @user = FactoryGirl.create(:user)
    visit root_path
  end
  
  it "logs in user" do
    click_link "Log In"
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    page.text.must_include "Log Out"
  end
      
  it "rejects login with invalid email" do
    click_link "Log In"
    fill_in "username", with: "fail@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    page.text.must_include "Login failed."
  end
  
  it "rejects login with invalid password" do
    click_link "Log In"
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "fail"
    click_button "Log In"
    page.text.must_include "Login failed."
  end
  
  it "logs out user" do
    click_link "Log In"
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
    page.text.must_include "Log Out"
    click_link "Log Out"
    page.text.must_include "Log In"
  end
  
  it "resets user's password" do
    skip
  end
  
end
