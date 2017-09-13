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

ActiveRecord::Schema.define(version: 20170901080753) do

  create_table "alarm_details", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "alarm_id"
    t.integer "alarm_record_id"
    t.string "color", default: "#ff0000", comment: "告警显示颜色"
    t.string "link_tag", comment: "链接"
    t.string "describe", comment: "简述"
    t.integer "active", default: 1, comment: "是否启用，0-否，1-是，-1删除"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alarm_id"], name: "index_alarm_details_on_alarm_id"
    t.index ["alarm_record_id"], name: "index_alarm_details_on_alarm_record_id"
  end

  create_table "alarm_records", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "alarm_id"
    t.string "kpi", comment: "告警kpi名称"
    t.string "kpi_vc", comment: "告警kpi阀值"
    t.string "kpi_vn", comment: "告警kpi当前值"
    t.string "kpi_method", comment: "告警kpi比对算法"
    t.string "describe", comment: "简述"
    t.string "color", default: "#ff0000", comment: "告警显示颜色设置"
    t.integer "active", default: 1, comment: "是否启用，0-否，1-是，-1删除"
    t.integer "alarm_status", default: 0, comment: "告警状态，0-停息，1-激活中，2-已关注"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alarm_id"], name: "index_alarm_records_on_alarm_id"
  end

  create_table "alarms", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", comment: "告警名称"
    t.string "action_name", default: "default_action_name", comment: "告警方法名称"
    t.integer "time_gran", comment: "时间粒度：5分钟／60分钟"
    t.integer "show_type", default: 1, comment: "展示方式，0多条／1一条"
    t.integer "active", default: 1, comment: "是否启用，0-否，1-是，-1删除"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
