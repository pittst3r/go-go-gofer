class UserMailer < ActionMailer::Base
  default from: "notifications@gofercommand.com"
  
  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail to: user.email, subject: "Your password has been reset"
  end
  
  def new_order_notification(order, recipient)
    @order = order
    @orderer = order.user
    @recipient = recipient
    mail to: @recipient.email, subject: "#{@orderer.name} just placed a new order"
  end
  
end
