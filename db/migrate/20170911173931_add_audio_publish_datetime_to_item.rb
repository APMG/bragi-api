class AddAudioPublishDatetimeToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :bragi_items, :audio_publish_datetime, :datetime
  end
end
