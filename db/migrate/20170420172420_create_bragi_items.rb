class CreateBragiItems < ActiveRecord::Migration[5.0]
  def change
    create_table :bragi_items do |t|
      t.float :sort
      t.string :audio_identifier, null: false
      t.string :audio_url, null: false
      t.string :audio_title, null: false
      t.text :audio_description
      t.text :audio_hosts
      t.string :audio_program
      t.string :origin_url
      t.string :source, null: false
      t.integer :playtime, null: false
      t.string :status, null: false
      t.datetime :finished
      t.references :bragi_user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
