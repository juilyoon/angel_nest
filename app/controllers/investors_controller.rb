class InvestorsController < ApplicationController
  inherit_resources
  belongs_to :user, :optional => true

  def index
    respond_to do |format|
      format.json { render :json => collection.for_auto_suggest }
      format.html { render 'users/index' }
    end
  end

  private

  def collection
    User.investors
  end
end
