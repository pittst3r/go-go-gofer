class DashboardController < ApplicationController
  before_filter :require_login
  
  def show
    @orders = Order.includes(:user).unaccepted.order("created_at DESC").all
    @gofer_run = current_user.gofer_runs.pending.first
  end
end
