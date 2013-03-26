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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130326181013) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "end_date"
    t.string   "file_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "guest_list"
  end

  create_table "up_files", :force => true do |t|
    t.string   "Url"
    t.string   "mail"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "event_id"
    t.string   "upload_file_file_name"
    t.string   "upload_file_content_type"
    t.integer  "upload_file_file_size"
    t.datetime "upload_file_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "mail"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
