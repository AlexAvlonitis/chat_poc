class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  MAIN_ROOM_NAME = 'main_room'

  def last_weeks_messages_count(to_date = DateTime.now)
    messages.where(created_at: 1.week.ago.beginning_of_day..to_date).count
  end
end
