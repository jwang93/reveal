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

ActiveRecord::Schema.define(:version => 20121118235629) do

  create_table "alumni", :force => true do |t|
    t.string   "major"
    t.string   "minor"
    t.string   "certificate"
    t.string   "company"
    t.float    "gpa"
    t.integer  "salary"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "alums", :force => true do |t|
    t.string   "first_major"
    t.string   "second_major"
    t.string   "third_major"
    t.string   "first_minor"
    t.string   "second_minor"
    t.string   "third_minor"
    t.string   "first_cert"
    t.string   "second_cert"
    t.string   "third_cert"
    t.string   "location"
    t.string   "industry"
    t.string   "company"
    t.integer  "salary"
    t.integer  "grad_year"
    t.float    "gpa"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "majors"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "minors"
    t.string   "certs"
  end

end
