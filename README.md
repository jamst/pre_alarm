## 为什么写这个程序
  *通过前置配置算法的方式实现轮询告警监控

### rake db:migrate
### rake db:seed

### 基于whenever支持定时设置频率



多条告警设置

 @@cache_read("uuids_list").inject({}) {|o,j| o["#{cache_read("#{j}_message")[:opxid].to_i}&#{cache_read("#{j}_message")[:ip]}"] = cache_read("#{j}_uuids") if cache_read("#{j}_uuids") > 1000 && cache_read("#{j}_message")  ; o }


 后台员工 #{Employee.find_by(id: @base_0.to_i )&.name} IP: #{@base_1} 访问大于1000次





单条告警

 @@cache_read("uuids_list").map{|uuid| cache_read("#{uuid}_uuids") }.max

 后台员工 #{@opxpid = cache_read("uuids_list").inject({}) {|o,j| o[j] = cache_read("#{j}_uuids"); o}.sort_by{|_|_[1]}.last&.first ; Employee.find_by(id: cache_read("#{@opxpid}_message")[:opxid].to_i )&.name } IP: #{cache_read("#{@opxpid}_message")[:ip] }访问大于3000次