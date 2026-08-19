class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
    
  end

  def create
    @sidebar_user = current_user
    @sidebar_book = Book.new(book_params)
    @sidebar_book.user = current_user

    if @sidebar_book.save
      redirect_to @sidebar_book, notice: "You have created book successfully."
    else
      @books = Book.all
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @sidebar_user = @book.user
    @sidebar_book = Book.new
  end

  def edit
    @sidebar_user = @book.user
    @sidebar_book = Book.new
  end

  def update
    @sidebar_user = @book.user
    @sidebar_book = Book.new

    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    redirect_to books_path unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end