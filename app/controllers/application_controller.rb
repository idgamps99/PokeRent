class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # before_action :store_location

  protected

  def configure_permitted_parameters
    # For additional fields in new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username])
    # For additional in edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar_name])
  end

  # Redirect user to home page after log in
  def after_sign_in_path_for(resource)
    root_path
  end

  # def store_location
  #   # Save the referring URL unless it’s a Devise path or an Ajax request
  #   unless request.fullpath =~ /\/users\/sign_in|\/users\/sign_up|\/users\/password|\/users\/sign_out|\/users\/edit/ || request.xhr?
  #     session[:return_to] = request.fullpath
  #   end
  # end
end
