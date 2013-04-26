require 'test_helper'

class BucketGroupsControllerTest < ActionController::TestCase
  test 'requires authentication for index' do
    get :index
    assert_redirected_to root_path
    get :index, { format: :json }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for create' do
    post :create, format: :json
    assert_redirected_to root_path
    post :create, { format: :json }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for update' do
    put :update, format: :json, id: 1
    assert_redirected_to root_path
    put :update, { format: :json, id: 1 }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for delete' do
    delete :destroy, format: :json, id: 1
    assert_redirected_to root_path
    delete :destroy, { format: :json, id: 1 }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'does not accept xml requests' do
    get :index, { format: :xml }, user_id: users(:jedhurt).id
    assert_response 406
  end

  test 'does not accept html requests' do
    get :index, { format: :html }, user_id: users(:jedhurt).id
    assert_response 406
  end

  test 'accepts json requests' do
    get :index, { format: :json }, user_id: users(:jedhurt).id
    assert_response 200
  end

  test 'scopes to current user' do
    get :index, { format: :json }, user_id: users(:jedhurt).id
    JSON.parse(response.body).
      all? { |bg| bg['user_id'] === users(:jedhurt).id }.
      must_equal true
  end
end
