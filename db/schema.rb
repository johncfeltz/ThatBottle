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

ActiveRecord::Schema.define(:version => 20080714135051) do

  create_table "acqtypes", :force => true do |t|
    t.string "acqtype"
  end

  create_table "acquisitions", :force => true do |t|
    t.date     "acqdate"
    t.text     "source"
    t.integer  "user_id",    :limit => 11
    t.integer  "acqtype_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appellations", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "parentappellation_id", :limit => 11
    t.integer  "apptype_id",           :limit => 11
    t.integer  "created_by",           :limit => 11
    t.integer  "updated_by",           :limit => 11
    t.integer  "winescount",           :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apptypes", :force => true do |t|
    t.string   "abbrev"
    t.string   "fullname"
    t.string   "translation"
    t.text     "notes"
    t.integer  "country_id",    :limit => 11
    t.integer  "nexthigher_id", :limit => 11
    t.integer  "created_by",    :limit => 11
    t.integer  "updated_by",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bottles", :force => true do |t|
    t.integer  "cellar_id",      :limit => 11
    t.integer  "cellarnum",      :limit => 11
    t.text     "cellarlabel"
    t.text     "cellarlocation"
    t.integer  "vintage",        :limit => 11
    t.float    "bottlesize"
    t.integer  "wine_id",        :limit => 11
    t.float    "alcohol"
    t.integer  "acquisition_id", :limit => 11
    t.integer  "disptype_id",    :limit => 11
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cellars", :force => true do |t|
    t.integer  "user_id",         :limit => 11
    t.integer  "topbottlenumber", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "isocode_num"
    t.string   "isocode_2let"
    t.string   "isocode_3let"
    t.text     "notes"
    t.integer  "created_by",   :limit => 11
    t.integer  "updated_by",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disptypes", :force => true do |t|
    t.string "disptype"
  end

  create_table "graperoles", :force => true do |t|
    t.string "role"
  end

  create_table "grapes", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "created_by", :limit => 11
    t.integer  "updated_by", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",       :limit => 11
    t.string   "name"
    t.string   "location"
    t.integer  "age",           :limit => 11
    t.text     "interests"
    t.text     "wineloves"
    t.text     "winehates"
    t.text     "memories"
    t.integer  "publicbottles", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tastingevents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tastingnotes", :force => true do |t|
    t.integer  "tastingevent_id", :limit => 11
    t.date     "tastingdate"
    t.integer  "tasteable_id",    :limit => 11
    t.string   "tasteable_type"
    t.integer  "vintage",         :limit => 11
    t.integer  "user_id",         :limit => 11
    t.text     "visual"
    t.text     "olfactory"
    t.text     "gustatory"
    t.integer  "score",           :limit => 11
    t.integer  "worth",           :limit => 11
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "handle"
    t.string   "fullname"
    t.date     "dob"
    t.string   "email"
    t.string   "password"
    t.integer  "userstatus_id",       :limit => 11
    t.integer  "betauser",            :limit => 11
    t.datetime "lastlogin"
    t.string   "authorization_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userstatuses", :force => true do |t|
    t.string "status"
  end

  create_table "valeventtypes", :force => true do |t|
    t.string "eventtype"
  end

  create_table "warehouses", :force => true do |t|
    t.integer  "user_id",          :limit => 11
    t.integer  "warehousetype_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warehousetypes", :force => true do |t|
    t.string "whtype"
  end

  create_table "winecolors", :force => true do |t|
    t.string "winecolor"
  end

  create_table "wines", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.text     "refs"
    t.string   "producer"
    t.integer  "appellation_id", :limit => 11
    t.integer  "winetype_id",    :limit => 11
    t.integer  "winecolor_id",   :limit => 11
    t.integer  "created_by",     :limit => 11
    t.integer  "updated_by",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "winetypes", :force => true do |t|
    t.string "winetype"
  end

end
