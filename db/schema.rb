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

ActiveRecord::Schema.define(version: 20160821181007) do

  create_table "admins", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chem_cat_ships", force: true do |t|
    t.integer  "chem_cat_id"
    t.integer  "chem_subcat_id"
    t.integer  "chemical_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chem_cat_ships", ["chem_cat_id"], name: "index_chem_cat_ships_on_chem_cat_id"
  add_index "chem_cat_ships", ["chem_subcat_id"], name: "index_chem_cat_ships_on_chem_subcat_id"
  add_index "chem_cat_ships", ["chemical_id"], name: "index_chem_cat_ships_on_chemical_id"

  create_table "chem_cats", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chem_subcats", force: true do |t|
    t.string   "name"
    t.integer  "chem_cat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chem_subcats", ["chem_cat_id"], name: "index_chem_subcats_on_chem_cat_id"

  create_table "chemicals", force: true do |t|
    t.string   "name"
    t.string   "iupac"
    t.string   "image"
    t.text     "description"
    t.string   "ld50"
    t.string   "origin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formula"
  end

  create_table "gmos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "developer"
    t.integer  "item_id"
    t.string   "trait"
    t.string   "dna_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gmos", ["item_id"], name: "index_gmos_on_item_id"

  create_table "item_chem_ships", force: true do |t|
    t.float    "percentage"
    t.integer  "item_id"
    t.integer  "chemical_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_chem_ships", ["chemical_id"], name: "index_item_chem_ships_on_chemical_id"
  add_index "item_chem_ships", ["item_id"], name: "index_item_chem_ships_on_item_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "literacies", force: true do |t|
    t.string   "word"
    t.text     "definition"
    t.integer  "literable_id"
    t.string   "literable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "literacies", ["literable_id", "literable_type"], name: "index_literacies_on_literable_id_and_literable_type"

end
