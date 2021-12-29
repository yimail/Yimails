class CreateLetterWithLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :letter_with_labels do |t|
      t.references :letter, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
