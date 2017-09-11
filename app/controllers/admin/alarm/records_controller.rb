class Admin::Alarm::RecordsController < Admin::BaseController

  def index
    @alarm_records = AlarmRecord.actived||[]
  end

  def alarm_analysis
  	@alarm_record = AlarmRecord.find(params[:id])
    @alarm_details = @alarm_record.alarm_details.limit(10)&.order(id: :desc)
  end

  # 忽略当前告警
  def ignore
    @alarm_record = AlarmRecord.find(params[:id])
    @alarm_record.update(alarm_status:2)
    @alarm_details = @alarm_record.alarm_details.update_all(active:0)
    redirect_to :action=>"index"
  end

  # 手动触发查询告警
  def fast_find
    @alarm_record = AlarmRecord.find(params[:id])
    @alarm_record.fast_find
    redirect_to :action=>"index"
  end
  	
end