class CreateLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :letters do |t|
      t.string :sender
      t.string :recipient
      t.string :subject
      t.text :content
      t.string :carbon_copy
      t.boolean :star
      t.string :blind_carbon_copy

      t.timestamps
    end
  end
end
