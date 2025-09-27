FactoryBot.define do
  factory :budget do
    month { 1 }
    year { Date.current.year }
    available_amount { 10.0 }
    status { "active" }

    association :user
  end
end
