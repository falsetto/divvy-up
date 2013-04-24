class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  before_create :build_default_bucket_group
  before_create :build_default_buckets
  has_many :bucket_groups
  has_many :buckets, through: :bucket_groups
  validates_presence_of :name, :provider, :uid

  def self.find_or_create_from_auth_hash(auth_hash)
    attrs = {
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      name: auth_hash[:info][:name]
    }
    find_or_create_by_uid(attrs)
  end

  private

  def build_default_bucket_group
    bucket_groups.build name: 'Default', amount: 1000
  end

  def build_default_buckets
    default_bucket_group = bucket_groups.first
    default_bucket_group.buckets.build name: 'Tithe', percentage: 0.1
    default_bucket_group.buckets.build name: 'Groceries', percentage: 0.1
    default_bucket_group.buckets.build name: 'Mortgage', percentage: 0.15
  end
end
