class UsersController < ApplicationController
  before_action :authenticate_user!
   before_action :setup, only: [:index, :show]

  def setup
    @book_new = Book.new
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @room = current_user.room_with?(@user)
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You successfully have updated your information"
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
