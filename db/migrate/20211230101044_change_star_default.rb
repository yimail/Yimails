class ChangeStarDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :letters, :star, false
  end
end
