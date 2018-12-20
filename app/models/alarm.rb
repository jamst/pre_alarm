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

     # crontab_5_pm
     def crontab_5_pm
        where(time_gran:-5).actived.each do |_|
         _.try(_.action_name)
       end
     end
   end

   # ************ 定义具体任务 ************

    # 通用告警算法告警
    def default_action_name
       alarm_records.each do |_|
        if self.show_type == 0
          # 多条告警模式
          # kpi_vn = @@{"a&b"=>1,"b&c"=>2}
          # Describe = #{@base_0}你好#{@base_1}
          base_b = (_.kpi_vn.to_s.include? "@@") ?  eval(_.kpi_vn.strip.gsub("@@","")) : _.kpi_vn
          base_b.to_a.each do |bb|
             _.a = (_.kpi_vc.to_s.include? "@@") ?  eval(_.kpi_vc.strip.gsub("@@","")) : _.kpi_vc
             _.b = bb[1]
             if _.kpi_method_execute 
                _.update(alarm_status:1) 
                bb[0].split("&").each_with_index do |bb_s,index|
                  eval %Q( @base_#{index} = '#{bb_s}' )
                end
                des = eval %Q( %Q(#{_.describe}) ) 
                AlarmDetail.create(alarm_id:_.alarm_id, alarm_record_id:_.id, color:_.color, describe:des) 
                Employee::set_employee_message(employee_id: self.employee_id,body: "#{des}",url: "/admin/alarm/records",publish_id: 1) unless Notification.where("body = '#{_.describe}' and read_at is null").present?
             else
                _.update(alarm_status:0)
             end   
          end   
        else
           # 同类型告警只显示一条
           _.a = (_.kpi_vc.to_s.include? "@@") ?  eval(_.kpi_vc.strip.gsub("@@","")) : _.kpi_vc
           _.b = (_.kpi_vn.to_s.include? "@@") ?  eval(_.kpi_vn.strip.gsub("@@","")) : _.kpi_vn
           if _.kpi_method_execute 
              _.update(alarm_status:1) 
              des = eval %Q( %Q(#{_.describe}) ) 
              AlarmDetail.create(alarm_id:_.alarm_id, alarm_record_id:_.id, color:_.color, describe:des) 
              Employee::set_employee_message(employee_id: self.employee_id,body: "#{des}",url: "/admin/alarm/records",publish_id: 1) unless Notification.where("body = '#{_.describe}' and read_at is null").present?
           else
              _.update(alarm_status:0)
           end
        end
       end
    end

end
