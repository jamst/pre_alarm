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

ActiveRecord::Schema.define(version: 20181218095824) do

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
    t.integer "employee_id", default: 1, comment: "接收人"
  end

  create_table "employees", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "员工表" do |t|
    t.string "email", default: "", null: false, comment: "email"
    t.string "encrypted_password", default: "", null: false, comment: "密码"
    t.integer "parent_id", default: 0, comment: "上级ID"
    t.datetime "created_at", null: false, comment: "创建日期"
    t.datetime "updated_at", null: false, comment: "修改日期"
    t.string "name", limit: 20, comment: "名字"
    t.integer "department_id", default: 0, null: false, comment: "部门ID"
    t.integer "position_id", default: 0, null: false, comment: "职位： 0:其它 6:财务 7:产品经理...."
    t.integer "position_level", default: 0, null: false, comment: "行政级别 0:员工 1:主管 2:经理 3:总监"
    t.integer "job_status", default: 1, null: false, comment: "在职状态, 1:在职, -1:离职"
    t.float "weight", limit: 24, default: 1.0, null: false, comment: "权重"
    t.date "joined_on", comment: "入职日期"
    t.integer "gender", comment: "性别 0:男 1:女"
    t.string "mobile", limit: 30, comment: "手机"
    t.string "qq", limit: 30, comment: "QQ"
    t.string "office_tel", limit: 30, comment: "公司电话"
    t.date "dob", comment: "生日"
    t.datetime "remember_created_at", comment: "记住创建日期"
    t.integer "deputy_department_id", default: 0, comment: "副部门"
    t.string "avatar", limit: 100, comment: "员工头像"
    t.integer "assign_count", default: 0, comment: "分配点数"
    t.integer "handover_id", default: 0, comment: "交接人"
    t.index ["email"], name: "index_employees_on_email", unique: true
  end

  create_table "employees_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "员工权限表" do |t|
    t.integer "employee_id", comment: "员工ID"
    t.integer "role_id", comment: "员工权限"
    t.index ["employee_id", "role_id"], name: "index_employees_roles_on_employee_id_and_role_id"
  end

  create_table "notifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "publisher_id"
    t.integer "state", default: 0
    t.string "title"
    t.string "body", limit: 5000
    t.string "link"
    t.datetime "sent_at"
    t.string "sent_code"
    t.string "sent_result"
    t.datetime "read_at"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "sending_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_id"], name: "index_notifications_on_publisher_id"
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["receiver_type", "receiver_id"], name: "index_notifications_on_receiver_type_and_receiver_id"
  end

  create_table "roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "角色表" do |t|
    t.string "name", comment: "角色名称"
    t.string "name_cn", comment: "中文名"
    t.datetime "created_at", comment: "创建日期"
    t.datetime "updated_at", comment: "修改日期"
    t.index ["name"], name: "index_roles_on_name"
  end

end
