class BucketsController < ApplicationController
  before_filter :set_headers

  respond_to :json

  def index
    headers['Access-Control-Allow-Origin'] = '*'
    @user = User.where(id: params[:user_id]).first
    @buckets = @user.buckets
    respond_with @buckets
  end
end
