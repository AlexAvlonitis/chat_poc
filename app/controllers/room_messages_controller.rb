class RoomMessagesController < ApplicationController
  before_action :set_room_message, only: [:show, :edit, :update, :destroy]

  # GET /room_messages
  def index
    @room_messages = RoomMessage.all
  end

  # GET /room_messages/1
  def show
  end

  # GET /room_messages/new
  def new
    @room_message = RoomMessage.new
  end

  # GET /room_messages/1/edit
  def edit
  end

  # POST /room_messages
  def create
    @room_message = RoomMessage.new(room_message_params)

    if @room_message.save
      redirect_to @room_message, notice: 'Room message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /room_messages/1
  def update
    if @room_message.update(room_message_params)
      redirect_to @room_message, notice: 'Room message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /room_messages/1
  def destroy
    @room_message.destroy
    redirect_to room_messages_url, notice: 'Room message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_message
      @room_message = RoomMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_message_params
      params.fetch(:room_message, {})
    end
end
