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

ActiveRecord::Schema.define(version: 2021_06_16_001250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "institutions", force: :cascade do |t|
    t.integer "opeid"
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "sector"
    t.string "duration_of_programs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["opeid"], name: "index_institutions_on_opeid", unique: true
  end

  create_table "program_classifications", force: :cascade do |t|
    t.integer "cip_code"
    t.string "cip_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "programs", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "program_classification_id", null: false
    t.integer "credential_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "year_published"
    t.string "official_pzf"
    t.string "appeal_status"
    t.decimal "annual_de_ratio", precision: 10, scale: 2
    t.decimal "median_annual_debt", precision: 10, scale: 2
    t.decimal "average_annual_earnings", precision: 10, scale: 2
    t.string "annual_pzf"
    t.decimal "discretionary_de_ratio"
    t.decimal "average_discretionary_earnings", precision: 10, scale: 2
    t.string "discretionary_pzf"
    t.decimal "transitional_de_ratio", precision: 10, scale: 2
    t.decimal "median_transitional_debt", precision: 10, scale: 2
    t.string "transitional_pzf"
    t.decimal "transitional_discretionary_de_ratio", precision: 10, scale: 2
    t.string "transitional_discretionary_pzf"
    t.decimal "mean_annual_earnings", precision: 10, scale: 2
    t.decimal "median_annual_earnings", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "programs", "institutions", on_delete: :cascade
  add_foreign_key "programs", "program_classifications", on_delete: :cascade
  add_foreign_key "reports", "programs", on_delete: :cascade
end
