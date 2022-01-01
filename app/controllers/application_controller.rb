class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_start_time
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_start_time
    @start_time = Time.now.usec
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  # def authenticate
  #  for if Rails.env.production?
  #     success = authenticate_or_request_with_http_basic('Hello Bicherwuerm!') do |username, password|
  #       username == 'user' && password == 'pass'
  #     end
  #   end
  # end
end

class Hash
  def compact
    delete_if { |_k, v| v.nil? }
  end
end
