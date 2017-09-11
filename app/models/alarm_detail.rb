class AlarmDetail < ApplicationRecord
  belongs_to :alarm
  belongs_to :alarm_record	
  include Activeable
end