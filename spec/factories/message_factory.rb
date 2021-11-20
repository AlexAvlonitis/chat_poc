FactoryBot.define do
  factory :message do
    content { 'this is a message' }
    user
    room
  end
end
