class ApplicationController < ActionController::Base

  layout :resolve_layout
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
  
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def resolve_layout
    if current_user && current_user.is_student?
      "student"
    else
      "application"
    end
  end

  protected

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"  
    redirect_to root_path
  end
end
