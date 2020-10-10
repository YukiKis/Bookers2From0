class RoomsController < ApplicationController
  def show
    room = Room.find(params[:id])
    room.users.each do |user|
      if user == current_user
      else
        @user = user
        debugger
      end
    end
    @messages = room.messages

  end
end
