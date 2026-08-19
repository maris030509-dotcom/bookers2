class RemoveIntroduceFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :introduce, :text
  end
end
