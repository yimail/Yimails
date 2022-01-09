class AddLabelIndentation < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :indentation, :integer
  end
end
