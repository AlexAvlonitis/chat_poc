require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
  end

  let(:user) { build(:user) }
  let(:room) { build(:room) }
  let!(:message1) { create(:message, created_at: 1.week.ago.midday - 1, room: room, user: user) }
  let!(:message2) { create(:message, created_at: 1.week.ago.midday, room: room, user: user) }
  let!(:message3) { create(:message, created_at: DateTime.now.midday, room: room, user: user) }
  let!(:message4) { create(:message, created_at: DateTime.now.end_of_day, room: room, user: user) }

  describe '#last_weeks_messages_count' do
    it 'returns all messages from last week midday to midday' do
      expect(room.last_weeks_messages_count).to eq 2
    end
  end

  describe '#custom_date_range_messages_count' do
    context 'when it has from and to params' do
      it 'returns all messages within the given range' do
        expect(room.custom_date_range_messages_count(from: 1.day.ago, to: DateTime.now.midday)).to eq 1
      end
    end

    context 'when from param is nil' do
      it 'returns all messages until given date' do
        expect(room.custom_date_range_messages_count(from: nil, to: DateTime.now.midday)).to eq 3
      end
    end

    context 'when to param is nil' do
      it 'returns all messages from given date' do
        expect(room.custom_date_range_messages_count(from: 1.day.ago, to: nil)).to eq 2
      end
    end
  end
end
