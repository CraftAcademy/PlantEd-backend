class UserPlant < ApplicationRecord
  include IceCube

  belongs_to :user
  belongs_to :plant

  validates_presence_of :user_id, :plant_id

  def schedule
    Schedule.new(start_date) do |s|
      s.add_recurrence_rule Rule.daily(self.frequency).until(Date.today + 30)
    end
  end

  def send_notification
    if Time.now < self.schedule.next_occurrence
      data = {notification: "#{self.user.email.split('@').first.humanize}, #{self.plant.name} needs to be watered!",
              user_id: self.user.id}
      BroadcastNotificationJob.perform_now(data)
    end if self.frequency && self.frequency != 0
  end

end
