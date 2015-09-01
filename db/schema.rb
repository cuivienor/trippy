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

ActiveRecord::Schema.define(version: 20150831235114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "google_place"
    t.string "latlong"
  end

  create_table "pois", force: :cascade do |t|
    t.string  "name"
    t.string  "google_place"
    t.string  "latlong"
    t.integer "location_id"
  end

  add_index "pois", ["location_id"], name: "index_pois_on_location_id", using: :btree

  create_table "pois_trips", force: :cascade do |t|
    t.integer "trip_id"
    t.integer "poi_id"
  end

  add_index "pois_trips", ["poi_id"], name: "index_pois_trips_on_poi_id", using: :btree
  add_index "pois_trips", ["trip_id"], name: "index_pois_trips_on_trip_id", using: :btree

  create_table "pois_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "poi_id"
  end

  add_index "pois_users", ["poi_id"], name: "index_pois_users_on_poi_id", using: :btree
  add_index "pois_users", ["user_id"], name: "index_pois_users_on_user_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string  "map_image"
    t.integer "user_id"
    t.integer "location_id"
    t.text    "directions",  array: true
    t.text    "stops",       array: true
  end

  add_index "trips", ["location_id"], name: "index_trips_on_location_id", using: :btree
  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "email"
  end

  add_foreign_key "pois", "locations"
  add_foreign_key "trips", "locations"
  add_foreign_key "trips", "users"
end
