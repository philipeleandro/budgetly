FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'email@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
