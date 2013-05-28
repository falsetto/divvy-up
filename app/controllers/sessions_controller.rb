class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to root_url
  end

  def destroy
    session['user_id'] = nil
    redirect_to root_url
  end

  def auth_failure
    flash[:error] = "Login failed with the following message: '#{params[:message].humanize}'. Please try again."
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
