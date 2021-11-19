class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy

  MAIN_ROOM_NAME = 'main_room'
end
