class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :office_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :address, :avatar])
  end
end
