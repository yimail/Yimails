class AddDeletedAtToLettets < ActiveRecord::Migration[6.1]
  def change
    add_column :letters,:deleted_at, :datetime
    add_index :letters, :deleted_at
  end
end
