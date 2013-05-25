class ApplicationController < ActionController::Base
  after_filter :set_csrf_cookie
  protect_from_forgery

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X_XSRF_TOKEN']
  end

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def redirect_if_logged_in
    redirect_to app_url if current_user
  end

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    return nil unless session[:user_id]
    @user ||= User.find(session[:user_id])
  end

  def authenticate
    current_user || redirect_to(root_url)
  end
end
