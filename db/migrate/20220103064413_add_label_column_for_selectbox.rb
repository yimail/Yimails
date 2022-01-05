class AddLabelColumnForSelectbox < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :hierarchy, :string
    add_column :labels, :display, :string
  end
end
