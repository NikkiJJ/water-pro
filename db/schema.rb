# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_10_171615) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bathing_sites", force: :cascade do |t|
    t.integer "pollution_level"
    t.string "site_name"
    t.string "tide"
    t.string "region"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bathing_sites_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "bathing_site_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bathing_site_id"], name: "index_favourites_on_bathing_site_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "ratings"
    t.date "date"
    t.bigint "bathing_site_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bathing_site_id"], name: "index_reviews_on_bathing_site_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bathing_sites", "users"
  add_foreign_key "favourites", "bathing_sites"
  add_foreign_key "favourites", "users"
  add_foreign_key "reviews", "bathing_sites"
  add_foreign_key "reviews", "users"
end
