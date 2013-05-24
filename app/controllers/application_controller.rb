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
    redirect_to e2e_test_aware_app_url if current_user
  end

  def e2e_test_aware_app_url
    if Rails.env == 'e2e-test'
      'http://localhost:8080/app'
    else
      '/app'
    end
  end

  def e2e_test_aware_root_url
    if Rails.env == 'e2e-test'
      'http://localhost:8080/'
    else
      '/'
    end
  end

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_user
    return nil unless session[:user_id]
    @user ||= User.find(session[:user_id])
  end

  def authenticate
    current_user || redirect_to('/')
  end
end
