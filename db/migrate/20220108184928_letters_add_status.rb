class LettersAddStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :letters, :status, :integer
    remove_column :letters, :content, :string
  end
end
