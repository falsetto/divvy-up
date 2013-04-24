require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'logs a user in' do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    User.stub :find_or_create_from_auth_hash, users(:jedhurt) do
      get :create
      session[:user_id].must_equal users(:jedhurt).id
      assert_redirected_to root_path
    end
  end

  test 'logs a user out' do
    session['user_id'] = 1
    get :destroy
    session['user_id'].must_equal nil
    assert_redirected_to root_path
  end
end
