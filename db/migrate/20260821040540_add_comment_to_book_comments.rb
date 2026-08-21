class AddCommentToBookComments < ActiveRecord::Migration[8.0]
  def change
    add_column :book_comments, :comment, :string
  end
end
