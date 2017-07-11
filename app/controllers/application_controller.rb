class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
  	{ locale: I18n.locale }
	end

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number])
  end


  private

  def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
  end
end
