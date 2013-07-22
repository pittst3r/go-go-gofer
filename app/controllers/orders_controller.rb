class OrdersController < ApplicationController
  before_filter :require_login
  before_filter :add_current_organization_to_params, only: :create
  after_filter :send_new_order_notifications, only: :create
  
  def index
    @orders = Order.all
  end
  
  def new
    @order = Order.new user: current_user
  end
  
  def create
    @order = Order.create(params[:order])
  end
  
  def destroy
    @order = Order.find(params[:id])
    description = @order.description
    if @order.destroy
      render nothing: true
    end
  end
  
  def accept
    @order = Order.find(params[:id])
    @order.add_to_new_or_existing_gofer_run
    @gofer_run = @order.gofer_run
  end
  
  protected
  
  def send_new_order_notifications
    @order.organization.users.each do |recipient|
      UserMailer.new_order_notification(@order, recipient).deliver if user_should_receive_notification(recipient)
    end
  end
  
  def user_should_receive_notification(recipient)
    if recipient.id != @order.user_id && recipient.order_email_notification_preference
      return true
    else
      false
    end
  end
  
end
