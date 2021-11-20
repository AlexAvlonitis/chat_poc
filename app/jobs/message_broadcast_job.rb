class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room, message, current_user)
    RoomChannel.broadcast_to(room, { message: message, current_user: current_user })
  end
end
