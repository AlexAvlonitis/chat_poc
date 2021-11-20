class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @messages = room.messages
  end
end
