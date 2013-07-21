class UserSessionsController < ApplicationController
  
  def new
    redirect_to dashboard_path if current_user
  end
  
  def create
    if @user = login(params[:username], params[:password])
      redirect_back_or_to dashboard_path, :notice => 'Login successful.'
    else
      flash.now[:alert] = "Login failed."
      render action: :new
    end
  end
  
  def destroy
    logout
    redirect_back_or_to root_path, :notice => 'Logout successful.'
  end
  
end
