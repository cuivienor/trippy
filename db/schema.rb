ActiveRecord::Schema.define(version: 20150828205020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "google_place"
    t.string "latlong"
  end

  create_table "pois", force: :cascade do |t|
    t.string "name"
    t.string "google_place"
    t.string "latlong"
  end

  create_table "trips", force: :cascade do |t|
    t.string  "map_image"
    t.integer "user_id"
    t.integer "location_id"
  end

  add_index "trips", ["location_id"], name: "index_trips_on_location_id", using: :btree
  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "trips_to_pois", force: :cascade do |t|
    t.integer "trip_id"
    t.integer "poi_id"
  end

  add_index "trips_to_pois", ["poi_id"], name: "index_trips_to_pois_on_poi_id", using: :btree
  add_index "trips_to_pois", ["trip_id"], name: "index_trips_to_pois_on_trip_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "email"
  end

  create_table "users_to_pois", force: :cascade do |t|
    t.integer "user_id"
    t.integer "poi_id"
  end

  add_index "users_to_pois", ["poi_id"], name: "index_users_to_pois_on_poi_id", using: :btree
  add_index "users_to_pois", ["user_id"], name: "index_users_to_pois_on_user_id", using: :btree

  add_foreign_key "trips", "locations"
  add_foreign_key "trips", "users"
end
