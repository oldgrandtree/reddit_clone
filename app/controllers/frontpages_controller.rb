class FrontpagesController < ApplicationController
  def show
    @user = User.new
  end
end
