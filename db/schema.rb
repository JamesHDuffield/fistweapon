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

ActiveRecord::Schema.define(version: 20160929022401) do

  create_table "api_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "url",        null: false
    t.text     "response"
    t.index ["url"], name: "index_api_requests_on_url", unique: true
  end

  create_table "discords", force: :cascade do |t|
    t.datetime "discord_timestamp"
    t.boolean  "pinned"
    t.string   "content"
    t.integer  "message_id",        limit: 8
    t.bigint   "channel_id"
    t.string   "author"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_type"
    t.string   "character"
    t.datetime "event_timestamp"
    t.string   "title"
    t.string   "description"
    t.integer  "itemId"
    t.integer  "achievementId"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "character_class"
  end

  create_table "guilds", force: :cascade do |t|
    t.string   "name"
    t.string   "realm"
    t.integer  "level"
    t.integer  "side"
    t.integer  "achievement_points"
    t.integer  "icon"
    t.string   "icon_colour"
    t.integer  "icon_colour_id"
    t.integer  "border"
    t.string   "border_colour"
    t.integer  "border_colour_id"
    t.string   "background_colour"
    t.integer  "background_colour_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "spec"
    t.integer  "character_class"
    t.string   "name"
    t.integer  "race"
    t.integer  "gender"
    t.integer  "level"
    t.integer  "rank"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "icon"
  end

  create_table "progressions", force: :cascade do |t|
    t.string   "raid"
    t.string   "boss"
    t.integer  "boss_id"
    t.integer  "lfr_kills"
    t.datetime "lfr_timestamp"
    t.integer  "normal_kills"
    t.datetime "normal_timestamp"
    t.integer  "heroic_kills"
    t.datetime "heroic_timestamp"
    t.integer  "mythic_kills"
    t.datetime "mythic_timestamp"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "character"
    t.datetime "posted"
    t.integer  "dkp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
