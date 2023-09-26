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

ActiveRecord::Schema[7.0].define(version: 2023_09_24_113900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bathing_sites", force: :cascade do |t|
    t.string "water_quality"
    t.string "site_name"
    t.string "tide"
    t.string "region"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "eubwid"
    t.string "web_res_image_url"
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

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "report_reviews", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "issue"
    t.text "comment"
    t.index ["review_id"], name: "index_report_reviews_on_review_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "bathing_site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "issue"
    t.text "comment"
    t.boolean "confirmation", default: false
    t.index ["bathing_site_id"], name: "index_reports_on_bathing_site_id"
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
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bathing_sites", "users"
  add_foreign_key "favourites", "bathing_sites"
  add_foreign_key "favourites", "users"
  add_foreign_key "report_reviews", "reviews"
  add_foreign_key "reports", "bathing_sites"
  add_foreign_key "reviews", "bathing_sites"
  add_foreign_key "reviews", "users"
end
