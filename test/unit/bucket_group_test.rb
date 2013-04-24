require 'test_helper'

class BucketGroupTest < ActiveSupport::TestCase
  before do
    @bucket_group = BucketGroup.new
  end

  test 'requires amount' do
    @bucket_group.valid?
    @bucket_group.errors[:amount].wont_be_empty
  end

  test 'amount must be a number' do
    @bucket_group.amount = 'five dollars'
    @bucket_group.valid?
    @bucket_group.errors[:amount].wont_be_empty
  end

  test 'allows mass assignment of amount' do
    BucketGroup.new(amount: 100)
  end

  test 'requires name' do
    @bucket_group.valid?
    @bucket_group.errors[:name].wont_be_empty
  end

  test 'allows mass assignment of name' do
    BucketGroup.new(name: 'Testing')
  end

  test 'has many buckets' do
    @bucket_group.reflections[:buckets].wont_be_nil
    @bucket_group.reflections[:buckets].macro.must_equal :has_many
  end

  test 'belongs to user' do
    @bucket_group.reflections[:user].wont_be_nil
    @bucket_group.reflections[:user].macro.must_equal :belongs_to
  end
end
