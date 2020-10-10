class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :setup
  
  def setup
    @book = Book.find(params[:book_id])
  end

  def create
  end

  def destroy
  end
end
