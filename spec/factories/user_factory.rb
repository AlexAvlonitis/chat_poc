FactoryBot.define do
  factory :user do
    name { 'tester' }
    email { 'tester@test.com' }
    password { 'password' }
  end
end
