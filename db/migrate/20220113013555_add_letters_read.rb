class AddLettersRead < ActiveRecord::Migration[6.1]
  def change
    add_column :letters, :read, :boolean, default: false
  end
end
