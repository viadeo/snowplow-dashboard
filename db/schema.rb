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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", id: false, force: true do |t|
    t.string   "app_id"
    t.string   "platform"
    t.datetime "collector_tstamp",                                               null: false
    t.datetime "dvce_tstamp"
    t.string   "event",                    limit: 128
    t.string   "event_vendor",             limit: 128,                           null: false
    t.string   "event_id",                 limit: 38,                            null: false
    t.integer  "txn_id"
    t.string   "v_tracker",                limit: 100
    t.string   "v_collector",              limit: 100,                           null: false
    t.string   "v_etl",                    limit: 100,                           null: false
    t.string   "user_id"
    t.string   "user_ipaddress",           limit: 19
    t.string   "user_fingerprint",         limit: 50
    t.string   "domain_userid",            limit: 16
    t.integer  "domain_sessionidx",        limit: 2
    t.string   "network_userid",           limit: 38
    t.string   "geo_country",              limit: 2
    t.string   "geo_region",               limit: 2
    t.string   "geo_city",                 limit: 75
    t.string   "geo_zipcode",              limit: 15
    t.float    "geo_latitude"
    t.float    "geo_longitude"
    t.string   "page_title",               limit: 2000
    t.string   "page_urlscheme",           limit: 16
    t.string   "page_urlhost"
    t.integer  "page_urlport"
    t.string   "page_urlpath",             limit: 1000
    t.string   "page_urlquery",            limit: 3000
    t.string   "page_urlfragment"
    t.string   "refr_urlscheme",           limit: 16
    t.string   "refr_urlhost"
    t.integer  "refr_urlport"
    t.string   "refr_urlpath",             limit: 1000
    t.string   "refr_urlquery",            limit: 3000
    t.string   "refr_urlfragment"
    t.string   "refr_medium",              limit: 25
    t.string   "refr_source",              limit: 50
    t.string   "refr_term"
    t.string   "mkt_medium"
    t.string   "mkt_source"
    t.string   "mkt_term"
    t.string   "mkt_content",              limit: 500
    t.string   "mkt_campaign"
    t.string   "se_category"
    t.string   "se_action"
    t.string   "se_label"
    t.string   "se_property"
    t.float    "se_value"
    t.string   "tr_orderid"
    t.string   "tr_affiliation"
    t.decimal  "tr_total",                              precision: 18, scale: 2
    t.decimal  "tr_tax",                                precision: 18, scale: 2
    t.decimal  "tr_shipping",                           precision: 18, scale: 2
    t.string   "tr_city"
    t.string   "tr_state"
    t.string   "tr_country"
    t.string   "ti_orderid"
    t.string   "ti_sku"
    t.string   "ti_name"
    t.string   "ti_category"
    t.decimal  "ti_price",                              precision: 18, scale: 2
    t.integer  "ti_quantity"
    t.integer  "pp_xoffset_min"
    t.integer  "pp_xoffset_max"
    t.integer  "pp_yoffset_min"
    t.integer  "pp_yoffset_max"
    t.string   "useragent",                limit: 1000
    t.string   "br_name",                  limit: 50
    t.string   "br_family",                limit: 50
    t.string   "br_version",               limit: 50
    t.string   "br_type",                  limit: 50
    t.string   "br_renderengine",          limit: 50
    t.string   "br_lang"
    t.boolean  "br_features_pdf"
    t.boolean  "br_features_flash"
    t.boolean  "br_features_java"
    t.boolean  "br_features_director"
    t.boolean  "br_features_quicktime"
    t.boolean  "br_features_realplayer"
    t.boolean  "br_features_windowsmedia"
    t.boolean  "br_features_gears"
    t.boolean  "br_features_silverlight"
    t.boolean  "br_cookies"
    t.string   "br_colordepth",            limit: 12
    t.integer  "br_viewwidth"
    t.integer  "br_viewheight"
    t.string   "os_name",                  limit: 50
    t.string   "os_family",                limit: 50
    t.string   "os_manufacturer",          limit: 50
    t.string   "os_timezone"
    t.string   "dvce_type",                limit: 50
    t.boolean  "dvce_ismobile"
    t.integer  "dvce_screenwidth"
    t.integer  "dvce_screenheight"
    t.string   "doc_charset",              limit: 128
    t.integer  "doc_width"
    t.integer  "doc_height"
  end

end
