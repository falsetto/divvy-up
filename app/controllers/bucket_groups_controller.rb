class BucketGroupsController < ApplicationController
  before_filter :authenticate
  respond_to :json
  inherit_resources

  protected

  def begin_of_association_chain
    current_user
  end
end
