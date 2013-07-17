require "test_helper"

describe "Gofer Run" do
  include ApplicationHelper
  
  before do
    @user = FactoryGirl.create(:user)
    @orders = []
    5.times { @orders << FactoryGirl.create(:order, description: Faker::Company.catch_phrase) }
    visit root_path
    click_link "Log In"
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
  end
  
  it "creates new gofer run" do
    click_link "Orders"
    check @orders[0].description
    check @orders[1].description
    click_button "Add to Gofer Run"
    page.text.must_include @orders[0].description
    page.text.must_include @orders[1].description
    page.text.wont_include @orders[2].description
    page.text.wont_include @orders[3].description
    page.text.wont_include @orders[4].description
    
    click_link "Orders"
    find("input[value='#{@orders[0].id}']")[:disabled].must_equal("disabled")
    find("input[value='#{@orders[1].id}']")[:disabled].must_equal("disabled")
  end
  
  it "lists all gofer runs" do
    click_link "Gofer Runs"
    page.text.must_include @orders[0].gofer_run.created_at.strftime("%F %H:%M")
    page.text.must_include @orders[0].description
    page.text.must_include @orders[1].description
  end
  
  it "shows gofer run" do
    skip
  end
  
  it "closes gofer run" do
    skip
  end
  
end
