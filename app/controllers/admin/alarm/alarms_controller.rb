class Admin::Alarm::AlarmsController < Admin::BaseController

  def index
    @q = SearchParams.new(params[:search_params] || {}) 
    search_params = @q.attributes(self)
    @alarms = ::Alarm.default_where(search_params).order(id: :desc).page(params[:page]).per(20)
  end

  def new
    @alarm = ::Alarm.new
    @alarm_records = [AlarmRecord.new]
  end

  def edit 
  	@alarm = ::Alarm.find(params[:id])
    @alarm_records = @alarm.alarm_records
  end

  def create 
    ::Alarm.transaction do 
      @alarm = ::Alarm.new(alarm_params)
      params[:alarm][:alarm_record].each do |index, spec|
        if spec[:kpi].present? 
          @alarm.alarm_records.new(spec.permit!.merge(color:params[:jscolor]))
        end
      end
      @alarm.save
    end  
  end

  def update
    ::Alarm.transaction do 
      @alarm = ::Alarm.find(params[:id])	
      @alarm.update(alarm_params)
      params[:alarm][:alarm_record].each do |index, spec|
        spec.permit!
        if spec[:id].present?
          new_spec = AlarmRecord.find(spec[:id])
          new_spec.attributes =  spec.merge(color:params[:jscolor])
          new_spec.save
        elsif spec[:kpi].present? 
          new_spec = @alarm.alarm_records.new(spec.merge(color:params[:jscolor]))
          new_spec.save
        end
      end
    end  
  end

  def delete
    @alarm_record = AlarmRecord.find params[:alarm_record_id].to_i
    @alarm_record_id = @alarm_record.id
    @alarm_record.delete
  end

  def alarm_params
    params.require(:alarm).permit(:name,
                                 :action_name,
                                 :time_gran,
                                 :time_gran)
  end
  	
end