class Alarm < ApplicationRecord
   has_many :alarm_records	
   has_many :alarm_details
   include Activeable	


   class << self	
	   # 5分钟粒度任务
	   def crontab_5_minute
	     where(time_gran:5).actived.each do |_|
	       _.try(_.action_name)
	     end
	   end

	   # 小时粒度任务
	   def crontab_60_minute
	     where(time_gran:60).actived.each do |_|
	       _.try(_.action_name)
	     end
	   end
   end

   # ************ 定义具体任务 ************

    # 通用告警算法告警
    def default_action_name
       alarm_records.each do |_|
         _.a = (_.kpi_vc.to_s.include? "@@") ?  eval(_.kpi_vc.strip.gsub("@@","")) : _.kpi_vc
         _.b = (_.kpi_vn.to_s.include? "@@") ?  eval(_.kpi_vn.strip.gsub("@@","")) : _.kpi_vn
         if _.kpi_method_execute 
            _.update(alarm_status:1) 
            AlarmDetail.create(alarm_id:_.alarm_id, alarm_record_id:_.id, color:_.color, describe:_.describe) 
            WhUtils::set_employee_message(1,"#{_.describe}","/admin/alarm/records",1) unless Notification.where("body = '#{_.describe}' and read_at is null").present?
         else
            _.update(alarm_status:0)
         end   
       end
    end

end
