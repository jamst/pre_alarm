class CreateAlarms < ActiveRecord::Migration[5.0]
  def change
    create_table :alarms do |t|
      t.string :name ,  comment: "告警名称"
      t.string :action_name , default: "default_action_name",  comment: "告警方法名称"  
      t.integer :time_gran ,  comment: "时间粒度：5分钟／60分钟"
      t.integer :show_type, default: 1 ,  comment: "展示方式，0多条／1一条" 
      t.integer :active, default: 1, comment: "是否启用，0-否，1-是，-1删除"
      t.timestamps  
    end
  end
end
