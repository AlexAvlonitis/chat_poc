require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:messages).dependent(:destroy) }

  describe '#last_message_date' do
    let(:user) { build(:user) }
    let(:room) { build(:room) }
    let(:date) { '01-11-2021'.to_date }
    let(:last_date) { '11-11-2021'.to_date }
    let!(:message1) { create(:message, created_at: date, room: room, user: user) }
    let!(:message2) { create(:message, created_at: last_date, room: room, user: user) }

    it 'returns the date of the last message' do
      expect(user.last_message_date).to eq last_date
    end
  end
end
