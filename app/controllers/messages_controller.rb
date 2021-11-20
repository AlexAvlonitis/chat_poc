class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = current_user.messages.new(content: params.dig(:message, :content), room: room)

    if message.save
      MessageBroadcastJob.perform_later(room, message, current_user)
      render nothing: true, status: :created
    else
      redirect_to rooms_url, alert: message.errors.full_messages
    end
  end
end
