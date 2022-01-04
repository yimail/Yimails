class AddDeletedAtToActionText < ActiveRecord::Migration[6.1]
  def change
    add_column :action_text_rich_texts,:deleted_at, :datetime
    add_index :action_text_rich_texts, :deleted_at
  end
end
