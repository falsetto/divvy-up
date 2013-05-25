class TestSupportController < ApplicationController
  def db_reset
    Bucket.delete_all
    BucketGroup.delete_all
    User.delete_all
    redirect_to root_url
  end
end
