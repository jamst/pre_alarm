class AlarmRecord < ApplicationRecord
	has_many :alarm_details
	belongs_to :alarm
    include Activeable
    attr_accessor :a ,:b

    enum alarm_status: {
      is_in_initial: 0,   # 已停息
      is_in_alarming: 1,  # 激活中
      is_in_watched: 2    # 已关注
    }

    # 执行判断是否产生告警
	def kpi_method_execute
      eval(kpi_method)
	end

    # 手动触发告警查询
	def fast_find
      alarm.try(alarm.action_name)
	end

end