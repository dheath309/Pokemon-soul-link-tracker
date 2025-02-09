# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_23_095512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_games_on_room_id", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.bigint "pokemon1_id", null: false
    t.bigint "pokemon2_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pokemon1_id"], name: "index_links_on_pokemon1_id"
    t.index ["pokemon2_id"], name: "index_links_on_pokemon2_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.integer "pokedex_id", default: 1, null: false
    t.boolean "is_alive", default: true, null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_boxed", default: false, null: false
    t.index ["team_id"], name: "index_pokemons_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  add_foreign_key "links", "pokemons", column: "pokemon1_id", on_delete: :cascade
  add_foreign_key "links", "pokemons", column: "pokemon2_id", on_delete: :cascade
  add_foreign_key "pokemons", "teams", on_delete: :cascade
  add_foreign_key "teams", "games", on_delete: :cascade
end
