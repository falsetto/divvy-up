class BucketGroup < ActiveRecord::Base
  attr_accessible :amount, :name
  validates_presence_of :amount, :name
  belongs_to :user
  has_many :buckets
end
