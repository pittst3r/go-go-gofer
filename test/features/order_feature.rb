require "test_helper"

describe "Order" do
  include ApplicationHelper
  
  @@description = "medium coffee with two pumps of simple syrup and two mississippis of half and half"
  
  before do
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link "Log In"
    fill_in "username", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
  end
  
  it "creates order for gofer" do
    click_link "New Order"
    fill_in "order_description", with: @@description
    click_button "Submit Order"
    page.text.must_include @@description
  end
  
  it "views all active orders for gofer" do
    @orders = []
    5.times { @orders << FactoryGirl.create(:order) }
    5.times { @orders << FactoryGirl.create(:order_from_random_user) }
    click_link "Orders"
    @orders.each do |r|
      page.text.must_include r.description
    end
  end
  
  it "deletes order for gofer" do
    @order = FactoryGirl.create(:order, description: @@description)
    click_link "Orders"
    first("a[href='#{order_path(@order)}']").click
    page.text.must_include "Order deleted"
    page.text.wont_include @@description
  end
  
end
