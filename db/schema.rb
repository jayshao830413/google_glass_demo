# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140720141731) do

  create_table "glass_timeline_items", force: true do |t|
    t.string   "type"
    t.integer  "google_account_id"
    t.string   "glass_item_id"
    t.boolean  "is_deleted"
    t.string   "glass_etag"
    t.string   "glass_self_link"
    t.string   "glass_kind"
    t.datetime "glass_created_at"
    t.datetime "glass_updated_at"
    t.string   "glass_content_type"
    t.text     "glass_content"
    t.datetime "display_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "glass_timeline_items", ["google_account_id"], name: "index_glass_timeline_items_on_google_account_id", using: :btree

  create_table "google_accounts", force: true do |t|
    t.string   "token"
    t.string   "refresh_token"
    t.integer  "expires_at"
    t.string   "email"
    t.string   "name"
    t.text     "id_token"
    t.string   "verification_secret"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "google_accounts", ["user_id"], name: "index_google_accounts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
