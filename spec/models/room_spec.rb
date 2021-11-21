require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe '#last_weeks_messages_count' do
    let(:user) { build(:user) }
    let(:room) { build(:room) }
    let!(:message1) { create(:message, created_at: 8.days.ago, room: room, user: user) }
    let!(:message2) { create(:message, created_at: 1.week.ago, room: room, user: user) }
    let!(:message3) { create(:message, room: room, user: user) }

    context 'when it does not have a date param' do
      it 'returns all messages from last week until now' do
        expect(room.last_weeks_messages_count).to eq 2
      end
    end

    context 'when it has a date param' do
      it 'returns all messages from last week until the given date' do
        expect(room.last_weeks_messages_count(1.day.ago)).to eq 1
      end
    end

    context 'when date param is nil' do
      it 'returns all messages until now' do
        expect(room.last_weeks_messages_count(nil)).to eq 3
      end
    end
  end
end
