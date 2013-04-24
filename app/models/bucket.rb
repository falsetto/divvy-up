class Bucket < ActiveRecord::Base
  default_scope order(:priority)
  attr_accessible :name, :priority_position, :percentage
  validates_presence_of :name
  validates :percentage, inclusion: (0..100)
  belongs_to :bucket_group

  include RankedModel
  ranks :priority, with_same: :bucket_group_id
end
