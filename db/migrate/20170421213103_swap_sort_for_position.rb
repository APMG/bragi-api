class SwapSortForPosition < ActiveRecord::Migration[5.0]
  def change
    remove_column :wojxorfgax_items, :sort, :float
    add_column :wojxorfgax_items, :position, :integer
  end
end
