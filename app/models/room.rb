class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  MAIN_ROOM_NAME = 'main_room'
end
