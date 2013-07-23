require "test_helper"

class OrderFeature < FeatureTest
  
  def setup
    super
    log_in_user
    @organization = FactoryGirl.create(:organization)
    @organization.users << @user
  end
  
  def test_place_new_order
    @random_user = FactoryGirl.create(:random_user)
    @organization.users << @random_user
    order_description = "coffee"
    visit dashboard_path
    find(".order.new").click
    fill_in "order[description]", with: order_description
    click_button "Go"
    sleep 1
    assert_includes page.text, order_description
    assert_includes page.text, @user.name
    mail = ActionMailer::Base.deliveries.last
    assert_equal 1, ActionMailer::Base.deliveries.count
    assert_equal @random_user.email, mail.to[0]
    assert_includes mail.body, order_description
  end
  
  def test_place_new_order_when_other_user_has_notifications_turned_off
    @random_user = FactoryGirl.create(:random_user)
    @organization.users << @random_user
    @random_user.update_preference :order_email_notification, false
    order_description = "coffee"
    visit dashboard_path
    find(".order.new").click
    fill_in "order[description]", with: order_description
    click_button "Go"
    sleep 1
    assert_includes page.text, order_description
    assert_includes page.text, @user.name
    assert_equal "false", @random_user.preferences.where(name: "order_email_notification").first.value
    mail = ActionMailer::Base.deliveries.last
    assert_equal 0, ActionMailer::Base.deliveries.count
  end
  
  def test_delete_order
    @order = FactoryGirl.create(:order, user: @user, organization: @organization)
    visit dashboard_path
    Capybara.match = :first
    find(".order[data-id] a").click
    sleep 2
    refute_includes page.text, @order.description
  end
  
  def test_accept_order
    @order = FactoryGirl.create(:order, user: @user, organization: @organization)
    visit dashboard_path
    Capybara.match = :first
    find(".order[data-id]").click
    sleep 2
    assert find("#your-gofer-run").has_content?(@order.description)
    refute find("#orders").has_content?(@order.description)
  end
  
  def test_view_only_recent_orders
    @order_recent = FactoryGirl.create(:order, description: "recent coffee", user: @user, organization: @organization)
    @order_old = FactoryGirl.create(:order, description: "old coffee", user: @user, organization: @organization, created_at: 1.day.ago)
    visit dashboard_path
    assert_includes page.text, @order_recent.description
    refute_includes page.text, @order_old.description
  end
  
end
