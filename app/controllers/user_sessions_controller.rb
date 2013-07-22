class UserSessionsController < ApplicationController
  
  def new
    redirect_to dashboard_path if current_user
  end
  
  def create
    if @user = login(params[:username], params[:password])
      flash[:notice] = "Welcome back, #{current_user.first_name}."
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Login failed."
      render action: :new
    end
  end
  
  def destroy
    user = current_user
    logout
    flash[:notice] = "Later, #{user.first_name}."
    redirect_to log_in_path
  end
  
end
