class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer_permit(:sign_up, keys: [:province, :first_name, :last_name, :is_admin, :address, :phone, :postal_code])
  end
end
