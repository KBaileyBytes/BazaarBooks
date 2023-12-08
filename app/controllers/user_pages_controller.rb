class UserPagesController < ApplicationController
  def show
    @page = UserPage.find(params[:id])
  end
end
