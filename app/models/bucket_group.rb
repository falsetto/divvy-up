class BucketGroup < ActiveRecord::Base
  attr_accessible :amount, :name
  validates_presence_of :name
  validates :amount, numericality: true
  belongs_to :user
  has_many :buckets
end
