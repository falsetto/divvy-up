class Bucket < ActiveRecord::Base
  attr_accessible :name, :order, :percentage, :user_id
  belongs_to :user
end
