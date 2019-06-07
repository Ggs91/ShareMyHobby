class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :date_of_birth, :description, :email, :password, :password_confirmation, :department_id, :phone_number, :profile_picture)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :date_of_birth, :description, :email, :password, :password_confirmation,:department_id, :phone_number, :profile_picture)}
  end
end
