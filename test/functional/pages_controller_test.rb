require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'provides an index page' do
    get :index
    assert_response :success
  end
end
