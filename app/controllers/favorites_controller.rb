class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :setup, only: [:create, :destroy]

  def setup
    @book = Book.find(params[:book_id])
    @fav = current_user.favorites.find_by(book: @book)
  end

  def create
    if @fav.present?
    else
      current_user.favorites.create(book: @book)
      redirect_to book_path(@book)
    end
  end

  def destroy
    if @fav.present?
      @fav.destroy
      redirect_to book_path(@book)
    end
  end

end
