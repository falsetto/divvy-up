require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '::find_or_create_from_auth_hash' do
    User.respond_to?(:find_or_create_from_auth_hash).must_equal true

    auth_hash = {
      provider: 'twitter',
      uid: 'u1234',
      info: {
        name: 'Jedidiah Hurt'
      }
    }
    user = User.find_or_create_from_auth_hash(auth_hash)
    user.must_be_instance_of User
  end

  before do
    @user = User.new
  end

  test 'requires name' do
    @user.valid?
    @user.errors[:name].wont_be_nil
  end

  test 'requires provider' do
    @user.valid?
    @user.errors[:provider].wont_be_nil
  end

  test 'requires uid' do
    @user.valid?
    @user.errors[:uid].wont_be_nil
  end

  test 'has many bucket groups' do
    @user.reflections[:bucket_groups].wont_be_nil
    @user.reflections[:bucket_groups].macro.must_equal :has_many
  end

  test 'has many buckets through bucket groups' do
    @user.reflections[:buckets].wont_be_nil
    assoc = @user.reflections[:buckets]
    assoc.macro.must_equal :has_many
    assoc.options.must_include :through
    assoc.options[:through].must_equal :bucket_groups
  end

  test 'builds default bucket group upon create' do
    user = User.create name: 'Test', provider: 'twitter', uid: '12341234'
    (user.bucket_groups.length > 0).must_equal true
    user.bucket_groups.first.name.wont_be_nil
    (user.buckets.length > 1).must_equal true
    user.buckets.first.name.wont_be_nil
  end

  test 'allows mass assignment of name' do
    User.new({ name: 'Testing' })
  end

  test 'allows mass assignment of provider' do
    User.new({ provider: 'twitter' })
  end

  test 'allows mass assignment of uid' do
    User.new({ uid: '12341234' })
  end

end
