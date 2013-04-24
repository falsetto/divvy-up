require 'test_helper'

class BucketsControllerTest < ActionController::TestCase
  test 'requires authentication for index' do
    get :index, bucket_group_id: 1
    assert_redirected_to root_path
    get :index, { bucket_group_id: 1, format: :json }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for create' do
    post :create, bucket_group_id: 1, format: :json
    assert_redirected_to root_path
    post :create, { bucket_group_id: 1, format: :json }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for update' do
    put :update, bucket_group_id: 1, format: :json, id: 1
    assert_redirected_to root_path
    put :update, { bucket_group_id: 1, format: :json, id: 1 }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'requires authentication for delete' do
    delete :destroy, bucket_group_id: 1, format: :json, id: 1
    assert_redirected_to root_path
    delete :destroy, { bucket_group_id: 1, format: :json, id: 1 }, user_id: users(:jedhurt).id
    response.status.to_s.first.wont_equal '3'
  end

  test 'responds to json' do
    skip
    get :index, {}, user_id: users(:jedhurt).id
    asssert_response 406
  end
end
