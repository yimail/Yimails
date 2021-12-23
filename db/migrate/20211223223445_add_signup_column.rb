class AddSignupColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
    add_column :users, :backup_email, :string
  end
end
