require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should have_many(:room_messages).dependent(:destroy) }
  end
end
