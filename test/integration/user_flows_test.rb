require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def login_via_twitter
    OmniAuth.config.test_mode = true
    get_via_redirect '/auth/twitter'
  end

  test 'visit home page when not logged in' do
    get root_path
    assert_response :success
  end

  test 'visit home page when logged in' do
    login_via_twitter
    get root_path
    assert_redirected_to app_path
  end

  test 'visit app page when not logged in' do
    get app_path
    assert_redirected_to root_path
  end

  test 'visit app page when logged in' do
    login_via_twitter
    get app_path
    assert_response :success
  end
end
