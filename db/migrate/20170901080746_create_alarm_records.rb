class CreateAlarmRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :alarm_records do |t|
      t.references :alarm	
      t.string :kpi ,  comment: "告警kpi名称"
      t.string :kpi_vc ,  comment: "告警kpi阀值"	
      t.string :kpi_vn ,  comment: "告警kpi当前值"	
      t.string :kpi_method ,  comment: "告警kpi比对算法"
      t.string :describe ,  comment: "简述" 
      t.string :color, default:"#ff0000" ,  comment: "告警显示颜色设置"
      t.integer :active, default: 1, comment: "是否启用，0-否，1-是，-1删除"
      t.integer :alarm_status, default: 0, comment: "告警状态，0-停息，1-激活中，2-已关注"
      t.timestamps		
    end
  end
end
