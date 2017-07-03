class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

def current_user
  if session[:user_token].present?
    @current_user ||= User.find_by(token: session[:user_token])
    session.clear if @current_user.nil?
    @current_user
  end
end

helper_method :current_user