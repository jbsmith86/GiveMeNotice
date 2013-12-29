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

ActiveRecord::Schema.define(version: 20131229090958) do

  create_table "alerts", force: true do |t|
    t.string   "name"
    t.boolean  "email_enabled"
    t.boolean  "sms_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "feed_username"
    t.integer  "feed_number"
    t.integer  "user_id"
    t.integer  "last_tweet_read"
  end

  create_table "keywords", force: true do |t|
    t.text     "phrase"
    t.integer  "alert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_accounts", force: true do |t|
    t.string   "twitter_username"
    t.string   "token"
    t.string   "secret"
    t.string   "twitteruid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "twitter_account_id"
    t.string   "sms_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
