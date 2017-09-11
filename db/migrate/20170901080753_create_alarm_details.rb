class CreateAlarmDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :alarm_details do |t|
      t.references :alarm
      t.references :alarm_record
      t.string :color, default:"#ff0000" ,  comment: "告警显示颜色"
      t.string :link_tag ,  comment: "链接" 
      t.string :describe ,  comment: "简述" 
      t.integer :active, default: 1, comment: "是否启用，0-否，1-是，-1删除"
      t.timestamps  
    end
  end
end
