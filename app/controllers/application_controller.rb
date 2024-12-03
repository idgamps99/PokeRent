class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :authenticate_user!

  protected

  def configure_permitted_parameters
    # For additional fields in new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    # For additional in edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end

  # Redirect user to home page after log in
  def after_sign_in_path_for(resource)
    root_path
  end
end
