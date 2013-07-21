class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def add_current_organization_to_params
    params[current_object][:organization_id] = current_organization.id
  end
  
  def current_organization
    organization = current_user.organizations.first
    return organization
  end
  
  def current_object
    params[:controller] ? params[:controller].singularize : nil
  end
  
  protected
  
  def not_authenticated
    redirect_to log_in_path, :alert => "Please login first."
  end
  
end
