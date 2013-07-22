class SettingsController < ApplicationController
  before_filter :require_login
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Settings updated."
      redirect_to settings_path
    else
      flash.now[:notice] = "There was a problem updating your settings. Please try again."
      render :edit
    end
  end
  
end
