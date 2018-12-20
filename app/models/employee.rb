class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :trackable, :validatable

  def self.get_all_with_options
    Rails.cache.fetch("all_employees", expires_in: 30.minute) do
     Employee.all.order(:name).map {|emp| [emp.name,emp.id]}
    end
  end      

   def self.set_employee_message(opt)
      return unless opt[:employee_id].to_i > 0
      Notification.create( receiver_id: opt[:employee_id],
                           receiver_type: 'Employee',
                           publisher_id: opt[:publish_id],
                           body: opt[:body],
                           link: opt[:url])
      #set_user_message(35973,body,url,publish_id=nil)
  end

end
