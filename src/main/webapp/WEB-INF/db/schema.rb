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

ActiveRecord::Schema.define(:version => 20101218144654) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "delayed_jobs_locked_by"
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "t_categories", :force => true do |t|
    t.string   "name",        :limit => 40,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "description", :limit => 100
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "t_categories", ["name", "parent_id"], :name => "index_category_name_pid"

  create_table "t_groups", :force => true do |t|
    t.string   "name",        :limit => 40
    t.string   "description", :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_groups_resources", :id => false, :force => true do |t|
    t.integer "resource_id"
    t.integer "group_id"
  end

  create_table "t_groups_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "t_groups_users", ["group_id"], :name => "index_t_groups_users_on_group_id"
  add_index "t_groups_users", ["user_id"], :name => "index_t_groups_users_on_user_id"

  create_table "t_properties", :force => true do |t|
    t.string  "prop_key",    :limit => 512
    t.string  "prop_value",  :limit => 4000
    t.integer "resource_id"
    t.integer "user_id"
  end

  create_table "t_resources", :force => true do |t|
    t.string   "resname",     :limit => 100
    t.string   "resurl",      :limit => 400
    t.string   "description", :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 500
    t.datetime "remember_token_expires_at"
  end

end
