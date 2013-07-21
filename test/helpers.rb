module SessionHelpers
  
  def log_in_user
    visit log_in_path
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
  end
  
end
