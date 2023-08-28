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

ActiveRecord::Schema[7.0].define(version: 2023_08_24_160230) do
  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "price"
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_programs_on_category_id"
    t.index ["user_id"], name: "index_programs_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "customer_name"
    t.integer "mobile"
    t.string "status"
    t.integer "user_id", null: false
    t.integer "program_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_purchases_on_program_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "blood_group"
    t.datetime "dob"
    t.integer "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "password_digest"
  end

  add_foreign_key "categories", "users"
  add_foreign_key "programs", "categories"
  add_foreign_key "programs", "users"
  add_foreign_key "purchases", "programs"
  add_foreign_key "purchases", "users"
end
