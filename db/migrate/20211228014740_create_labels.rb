class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :title
      t.string :state
      t.string :group

      t.timestamps
    end
  end
end
