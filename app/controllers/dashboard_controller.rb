class DashboardController < ApplicationController
  before_filter :require_login
  
  def show
    @orders = Order.includes(:user).in_organization(current_organization).unaccepted.order("created_at DESC").all
    @gofer_run = current_user.gofer_runs.in_organization(current_organization).pending.first
  end
end
