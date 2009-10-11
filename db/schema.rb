# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090927130919) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "owner_user_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_albums", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.integer  "photo_id"
  end

  create_table "photo_comments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_id"
    t.integer  "comment_id"
  end

  create_table "photo_tags", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_id"
    t.integer  "tag_id"
  end

  create_table "photo_users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_id"
    t.integer  "user_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "filename"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.string   "title"
    t.string   "original_filename"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "sharing_type_id"
  end

  create_table "sharing_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "group_id"
  end

  create_table "user_users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "invited_user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

end
