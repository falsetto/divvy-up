class BucketsController < ApplicationController
  before_filter :authenticate
  respond_to :json
  inherit_resources
  belongs_to :bucket_group

  protected

  def begin_of_association_chain
    current_user
  end
end
