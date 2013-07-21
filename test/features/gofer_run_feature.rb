require "test_helper"

class GoferRunFeature < FeatureTest
  
  def setup
    super
    log_in_user
    @organization = FactoryGirl.create(:organization)
    @organization.users << @user
  end
  
  def test_clear_gofer_run
    @order = FactoryGirl.create(:order, user: @user, organization: @organization)
    @order.add_to_new_or_existing_gofer_run
    visit dashboard_path
    assert find("#your-gofer-run").has_content?(@order.description)
    click_button "Reset"
    sleep 2
    refute find("#your-gofer-run").has_content?(@order.description)
    assert find("#orders").has_content?(@order.description)
  end
  
  def test_close_gofer_run
    @order = FactoryGirl.create(:order, user: @user, organization: @organization)
    @order.add_to_new_or_existing_gofer_run
    visit dashboard_path
    assert find("#your-gofer-run").has_content?(@order.description)
    click_button "Done"
    sleep 2
    refute find("#your-gofer-run").has_content?(@order.description)
    refute find("#orders").has_content?(@order.description)
    assert_includes page.text, "No current gofer run"
  end
  
end
