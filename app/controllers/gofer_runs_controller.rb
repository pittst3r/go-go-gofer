class GoferRunsController < ApplicationController
  before_filter :require_login
  
  def clear
    @gofer_run = GoferRun.find(params[:id])
    @gofer_run.clear_orders
    @orders = Order.includes(:user).unaccepted.order("created_at DESC").all
  end
  
  def close
    @gofer_run = GoferRun.find(params[:id])
    @gofer_run.close
    @orders = Order.includes(:user).unaccepted.order("created_at DESC").all
  end
  
end
