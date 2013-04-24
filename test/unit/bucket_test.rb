require 'test_helper'

class BucketTest < ActiveSupport::TestCase
  before do
    @bucket = Bucket.new
  end

  test 'requires name' do
    @bucket.valid?
    @bucket.errors[:name].wont_be_nil
  end

  test 'allows mass assignment of name' do
    Bucket.new(name: 'Testing')
  end

  test 'requires percentage' do
    @bucket.valid?
    @bucket.errors[:percentage].wont_be_nil
  end

  test 'allows mass assignment of percentage' do
    Bucket.new(percentage: 0.1)
  end

  test 'belongs to bucket group' do
    @bucket.reflections[:bucket_group].wont_be_nil
    @bucket.reflections[:bucket_group].macro.must_equal :belongs_to
  end
end
