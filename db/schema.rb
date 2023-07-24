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

ActiveRecord::Schema[7.0].define(version: 2023_07_24_160139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "glossary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glossary_id"], name: "index_collects_on_glossary_id"
    t.index ["user_id"], name: "index_collects_on_user_id"
  end

  create_table "glossaries", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.boolean "is_system", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
  end

  create_table "sentences", force: :cascade do |t|
    t.string "content"
    t.bigint "vocabulary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "translation", null: false
    t.index ["vocabulary_id"], name: "index_sentences_on_vocabulary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "display", null: false
    t.string "secondly_display"
    t.text "description"
    t.string "pronunciation", null: false
    t.integer "language", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "translation", null: false
  end

end
