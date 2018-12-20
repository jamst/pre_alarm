class AddEmployeeIdToAlarms < ActiveRecord::Migration[5.1]
  def change
  	add_column :alarms, :employee_id, :integer, default: 1, comment: "接收人"
  end
end
