class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  MAIN_ROOM_NAME = 'main_room'

  def last_weeks_messages_count
    messages_at_date(1.week.ago.midday, DateTime.now.midday).count
  end

  def custom_date_range_messages_count(from:, to:)
    messages_at_date(from, to).count
  end

  private

  def messages_at_date(from, to)
    messages.where(created_at: from..to)
  end
end
