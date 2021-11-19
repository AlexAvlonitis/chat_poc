class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = room(params[:room])
    return unless room

    stream_for(room)
  end

  private

  def room(name)
    @room ||= Room.find_by(name: name || Room::MAIN_ROOM_NAME)
  end
end
