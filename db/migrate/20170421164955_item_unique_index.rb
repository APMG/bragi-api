class ItemUniqueIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :bragi_items, [:bragi_user_id, :audio_identifier], unique: true, name: 'index_bragi_items_on_user_id_and_audio_identifier'
  end
end
