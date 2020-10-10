class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :setup, only: [:index, :show]

  def setup
    @book_new = current_user.books.new
  end

  def index
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to book_path(@book)
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to book_path(@book)
    else
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have successfully updated it"
      else
        render "edit"
      end
    end
  end

  def create
    @book_new = current_user.books.new(book_params)
    if @book_new.save
      redirect_to book_path(@book_new), notice: "You have successfully made a new book"
    else
      @user = current_user
      render "users/show"
    end
  end

  def destroy
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    if current_user == user
      book.destroy
      redirect_to user_path(user)
    else
      redirect_to user_path(user)
    end
  end

  def search
    @search = search_params[:search]
    @user_book = search_params[:user_book]
    @how = search_params[:how]
    @books = []
      case @user_book
      when "Users"
        case @how
        when "完全一致" 
          @books = Book.by_user_whole(@search)
        when "前方一致" 
          @books = Book.by_user_headpart(@search)
        when "後方一致" 
          @books = Book.by_user_tailpart(@search)
        when "部分一致"
          @books = Book.by_user_part(@search)
        end
      when "Books"
        case @how
        when "完全一致"
          @books = Book.by_title_whole(@search)
        when "前方一致"
          @books = Book.by_title_headpart(@search)
        when "後方一致"
          @books = Book.by_title_tailpart(@search)
        when "部分一致"
          @books = Book.by_title_part(@search)
        end
      end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def search_params
      params.require(:search).permit(:search, :user_book, :how)
    end
end
