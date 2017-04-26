class SwapSortForPosition < ActiveRecord::Migration[5.0]
  def change
    remove_column :bragi_items, :sort, :float
    add_column :bragi_items, :position, :integer
  end
end
