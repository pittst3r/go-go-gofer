class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def add_current_organization_to_params
    params[current_object][:organization_id] = current_organization.id
  end
  
  def current_organization
    organization = current_user.organizations.first
    raise NilObject, "'organization_id' must not be an Integer." if organization.nil?
    return organization
  end
  
  def current_object
    params[:controller] ? params[:controller].singularize : nil
  end
  
end
