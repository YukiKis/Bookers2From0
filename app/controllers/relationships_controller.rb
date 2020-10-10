class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :setup, only: [:create, :destroy]

  def setup
    @user = User.find(params[:user_id])
  end

  def create
    if current_user.following?(@user)
    else
      current_user.follow(@user)
    end
  end

  def destroy
    if current_user.following?(@user)
      current_user.unfollow(@user)
    end
  end
end
