require 'test_helper'

class TestSupportControllerTest < ActionController::TestCase
  test 'deletes all user data' do
    bucket = TestSupportController::Bucket = MiniTest::Mock.new
    bucket_group = TestSupportController::BucketGroup = MiniTest::Mock.new
    user = TestSupportController::User = MiniTest::Mock.new
    bucket.expect :delete_all, true
    bucket_group.expect :delete_all, true
    user.expect :delete_all, true

    get :db_reset

    bucket.verify
    bucket_group.verify
    user.verify
    assert_redirected_to root_url
  end
end
