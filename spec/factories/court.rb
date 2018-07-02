FactoryBot.define do
  factory :court do
    enabled { true }
    name { Faker::Lorem.sentence }

    trait :unavailable do
      enabled { false }
    end
  end
end
