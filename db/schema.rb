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

ActiveRecord::Schema.define(version: 20130803210220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drugs", force: true do |t|
    t.string   "name"
    t.string   "form"
    t.string   "manufacturer"
    t.string   "distribution"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs_substances", id: false, force: true do |t|
    t.integer "drug_id",      null: false
    t.integer "substance_id", null: false
  end

  add_index "drugs_substances", ["drug_id"], name: "index_drugs_substances_on_drug_id", using: :btree
  add_index "drugs_substances", ["substance_id"], name: "index_drugs_substances_on_substance_id", using: :btree

  create_table "substances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
