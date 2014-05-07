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

ActiveRecord::Schema.define(version: 20140507035910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.text     "body"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracting_officers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "projects_count"
  end

  create_table "documents", force: true do |t|
    t.string   "document_file_name"
    t.integer  "document_file_size"
    t.string   "document_content_type"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachable_type"
    t.integer  "attachable_id"
  end

  create_table "meetings", force: true do |t|
    t.datetime "date"
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "plan_holders", force: true do |t|
    t.integer  "project_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "projects", force: true do |t|
    t.string   "project_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.string   "contracting_officer_email"
    t.datetime "closing_date"
    t.datetime "question_closing_date"
    t.integer  "contracting_officer_id"
    t.integer  "questions_count"
    t.string   "status"
    t.string   "mail_hash"
    t.datetime "preproposal_conf_date"
    t.boolean  "prebid_conf",               default: false
    t.boolean  "site_visit_planned",        default: false
    t.boolean  "draft"
    t.datetime "site_visit_date"
  end

  create_table "questions", force: true do |t|
    t.text     "body"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question_method"
    t.integer  "answers_count",   default: 0
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
