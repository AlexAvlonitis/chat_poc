class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  MAIN_ROOM_NAME = 'main_room'

  def last_weeks_messages_count(from_date = 1.week.ago.beginning_of_day)
    messages.where(created_at: from_date..DateTime.now).count
  end
end
