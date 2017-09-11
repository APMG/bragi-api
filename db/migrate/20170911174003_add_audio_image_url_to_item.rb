class AddAudioImageUrlToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :bragi_items, :audio_image_url, :text
  end
end
