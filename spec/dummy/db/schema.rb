# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170421170508) do

  create_table "wojxorfgax_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "sort",               limit: 24
    t.string   "audio_identifier",                 null: false
    t.string   "audio_url",                        null: false
    t.string   "audio_title",                      null: false
    t.text     "audio_description",  limit: 65535
    t.text     "audio_hosts",        limit: 65535
    t.string   "audio_program"
    t.string   "origin_url"
    t.string   "source",                           null: false
    t.integer  "playtime",                         null: false
    t.integer  "status",                           null: false
    t.datetime "finished"
    t.integer  "wojxorfgax_user_id",               null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["wojxorfgax_user_id", "audio_identifier"], name: "index_wojxorfgax_items_on_user_id_and_audio_identifier", unique: true, using: :btree
    t.index ["wojxorfgax_user_id"], name: "index_wojxorfgax_items_on_wojxorfgax_user_id", using: :btree
  end

  create_table "wojxorfgax_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "external_uid", null: false
    t.string   "secret_uid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "wojxorfgax_items", "wojxorfgax_users"
end
