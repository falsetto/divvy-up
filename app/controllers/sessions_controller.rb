class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to e2e_test_aware_root_url
  end

  def destroy
    session['user_id'] = nil
    redirect_to e2e_test_aware_root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
