class AddLettersUserName < ActiveRecord::Migration[6.1]
  def change
    add_column :letters, :recipient_name, :string
  end
end