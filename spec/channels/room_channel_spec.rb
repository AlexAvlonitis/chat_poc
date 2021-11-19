require 'rails_helper'

RSpec.describe RoomChannel, type: :channel do
  let(:room_name) { 'main_room' }
  let(:room) { instance_double(Room, name: room_name) }

  before do
    stub_connection(rooms: room.name)

    allow(Room).to receive(:find_by).with(name: room_name).and_return(room)
    allow(Room).to receive(:find_by).with(name: 'invalid_room').and_return(nil)
  end

  it "subscribes to a stream when room name is provided" do
    subscribe(room: room_name)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(room)
  end

  it "subscribes to a default stream when room name is not provided" do
    subscribe

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(room)
  end

  it "does not subscribe to a stream when room does not exist" do
    subscribe(room: 'invalid_room')

    expect(subscription).to be_confirmed
    expect(subscription).not_to have_streams
  end
end
