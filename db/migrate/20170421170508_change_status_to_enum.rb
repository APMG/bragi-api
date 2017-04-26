class ChangeStatusToEnum < ActiveRecord::Migration[5.0]
  def up
    change_column :bragi_items, :status, :integer
  end

  def down
    change_column :bragi_items, :status, :string
  end
end
