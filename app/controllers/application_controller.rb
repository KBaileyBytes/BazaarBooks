class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_pages

  protected

  def set_user_pages
    @user_pages = UserPage.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id, :first_name, :last_name, :is_admin, :address, :phone, :postal_code])
  end

  helper_method :set_user_pages
end
