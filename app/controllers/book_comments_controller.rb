class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    book_comment = book.book_comments.new(book_comment_params)
    book_comment.user_id = Current.user.id
    book_comment.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    book_comment = book.book_comments.find(params[:id])

    if book_comment.user_id == Current.user.id
       book_comment.destroy
    end

    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
