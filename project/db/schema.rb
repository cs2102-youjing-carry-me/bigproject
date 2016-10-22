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

ActiveRecord::Schema.define(version: 20161022091623) do

  create_table "bids", primary_key: ["stuff_create_time", "owner_username", "bidder_username"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "stuff_create_time", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string   "owner_username",                                         null: false
    t.string   "bidder_username",                                        null: false
    t.integer  "bidding_points",    default: 50
    t.boolean  "status"
    t.datetime "create_time",       default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "update_time",       default: -> { "CURRENT_TIMESTAMP" }
    t.index ["bidder_username"], name: "bidder_username", using: :btree
    t.index ["owner_username"], name: "owner_username", using: :btree
  end

  create_table "stuffs", primary_key: ["create_time", "owner_username"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "stuff_name"
    t.string   "stuff_description", limit: 1000
    t.string   "stuff_type",        limit: 25
    t.string   "owner_username",                                                      null: false
    t.string   "pick_up_point"
    t.string   "return_point"
    t.integer  "cost",                           default: 0
    t.boolean  "availability"
    t.datetime "pick_up_time"
    t.datetime "return_time"
    t.datetime "create_time",                    default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "end_time",                       default: -> { "CURRENT_TIMESTAMP" }
    t.index ["owner_username"], name: "owner_username", using: :btree
  end

  create_table "users", primary_key: "username", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.boolean  "isAdmin"
    t.integer  "points",                 default: 50
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "bids", "stuffs", column: "owner_username", primary_key: "owner_username", name: "bids_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bids", "stuffs", column: "stuff_create_time", primary_key: "create_time", name: "bids_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bids", "users", column: "bidder_username", primary_key: "username", name: "bids_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stuffs", "users", column: "owner_username", primary_key: "username", name: "stuffs_ibfk_1", on_update: :cascade, on_delete: :cascade
end
