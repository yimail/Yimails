class RemoveAuthyId < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, name: :index_users_on_authy_id
  end
end
