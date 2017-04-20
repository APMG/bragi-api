class CreateWojxorfgaxUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :wojxorfgax_users do |t|
      t.string :external_uid, null: false
      t.string :secret_uid

      t.timestamps
    end
  end
end
