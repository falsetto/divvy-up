class PagesController < ApplicationController
  before_filter :authenticate, only: 'app'
  before_filter :redirect_if_logged_in, only: 'index'
  layout 'marketing', only: 'index'

  def index; end

  def app; end
end
