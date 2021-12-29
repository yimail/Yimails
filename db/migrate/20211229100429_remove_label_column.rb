class RemoveLabelColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :labels, :state, :string
  end
end
