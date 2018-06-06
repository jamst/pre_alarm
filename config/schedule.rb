set :output, { error: 'log/whenever_error.log', standard: 'log/whenever.log' }
job_type :rake,  "export PATH=\"$HOME/.rbenv/bin:$PATH\" ; eval \"$(rbenv init -)\"; cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"
job_type :runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\" ; eval \"$(rbenv init -)\"; cd :path &&  RAILS_ENV=:environment bundle exec rails runner ':task' :output"

# 每5分钟一次 自动告警监控
every 60.minutes do
  runner 'Alarm.crontab_5_minute'
end

# 每60分钟一次 自动告警监控
every 60.minutes do
  runner 'Alarm.crontab_60_minute'
end

#每天下午5.00点
every 1.day, :at => '05:00 pm' do
  runner 'Alarm.crontab_5_pm'
end