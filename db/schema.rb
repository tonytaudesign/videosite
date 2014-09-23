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

ActiveRecord::Schema.define(version: 20140804002608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "searches", force: true do |t|
    t.integer  "age"
    t.string   "sex"
    t.string   "location"
    t.string   "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.integer  "age"
    t.string   "youtube_url"
    t.string   "youtube_user_url"
    t.string   "aws_url"
    t.string   "sex"
    t.string   "thumbnail"
    t.string   "location"
    t.string   "expiration"
    t.string   "client_access_token"
    t.string   "client_refresh_token"
    t.string   "refresh_token"
    t.string   "title"
    t.string   "description"
    t.string   "category"
    t.string   "keywords"
    t.string   "author"
    t.string   "duration"
    t.string   "yt_video_id"
    t.string   "yt_user_video_id"
    t.integer  "likes"
    t.integer  "dislikes"
    t.boolean  "is_complete",          default: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
