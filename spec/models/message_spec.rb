require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe '#short_date' do
    let(:user) { build(:user) }
    let(:room) { build(:room) }
    let(:date) { '01-11-2021'.to_date }
    let!(:message) { build(:message, created_at: date, room: room, user: user) }

    it 'returns a short version of the date' do
      expect(message.short_date).to eq '01 Nov 00:00'
    end
  end

  describe '#to_hash' do
    let(:user) { build(:user) }
    let(:room) { build(:room) }
    let(:date) { '01-11-2021'.to_date }
    let!(:message) { build(:message, created_at: date, room: room, user: user) }

    it 'returns hash of custom values' do
      expect(message.to_hash).to eq({ content: message.content, short_date: '01 Nov 00:00' })
    end
  end
end
