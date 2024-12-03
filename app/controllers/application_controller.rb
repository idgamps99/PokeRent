class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avater])
  end

  # Redirect user to home page after log in
  def after_sign_in_path_for(resource)
    root_path
  end
end
