class AddUsersLettersReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :letters, :user, index: true
  end
end
