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

ActiveRecord::Schema[7.1].define(version: 2023_12_17_163116) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_favorites_on_review_id"
    t.index ["user_id", "review_id"], name: "index_favorites_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "domain", limit: 260, null: false
    t.string "name", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_organizers_on_domain", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "web_page_id", null: false
    t.string "title", limit: 200, null: false
    t.string "content", limit: 1000, null: false
    t.datetime "implementation_start_date", null: false
    t.datetime "implementation_lase_date", null: false
    t.datetime "recruitment_start_date"
    t.datetime "recruitment_lase_date"
    t.string "prefecture", limit: 5
    t.integer "fee"
    t.integer "target", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["web_page_id"], name: "index_reviews_on_web_page_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id", "tag_id"], name: "index_taggings_on_review_id_and_tag_id", unique: true
    t.index ["review_id"], name: "index_taggings_on_review_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "twitter_name", null: false
    t.string "twitter_id", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_id"], name: "index_users_on_twitter_id", unique: true
  end

  create_table "web_pages", force: :cascade do |t|
    t.bigint "organizer_id", null: false
    t.string "url", limit: 260, null: false
    t.string "opg_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_web_pages_on_organizer_id"
    t.index ["url"], name: "index_web_pages_on_url", unique: true
  end

  add_foreign_key "favorites", "reviews"
  add_foreign_key "favorites", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "web_pages"
  add_foreign_key "taggings", "reviews"
  add_foreign_key "taggings", "tags"
  add_foreign_key "web_pages", "organizers"
end
