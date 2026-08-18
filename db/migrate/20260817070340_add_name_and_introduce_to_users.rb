class AddNameAndIntroduceToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :introduce, :text
    
    add_index :users, :name, unique: true
  end

  
end
