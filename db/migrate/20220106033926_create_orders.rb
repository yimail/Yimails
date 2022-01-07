class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :username
      t.string :address

      t.timestamps
    end
  end
end
