class AddUsersLabelsReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :labels, :user, index: true
  end
end
