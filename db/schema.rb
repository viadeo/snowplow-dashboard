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

ActiveRecord::Schema.define(version: 20140426145632) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "job_stats", force: true do |t|
    t.string   "dashboard"
    t.string   "chart"
    t.datetime "started_at"
    t.integer  "duration",         limit: 8
    t.integer  "waiting_duration", limit: 8
    t.integer  "integer",          limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_stats", ["dashboard", "chart"], name: "index_job_stats_on_dashboard_and_chart"
  add_index "job_stats", ["started_at"], name: "index_job_stats_on_started_at"

end
