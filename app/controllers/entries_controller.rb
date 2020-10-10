class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :setup, only: [:create]

  def setup
    @user = User.find(params[:user_id])
  end

  def create
    room = Room.create
    current_user.entries.create(room: room)
    @user.entries.create(room: room)
    redirect_to room_path(room)
  end
end
