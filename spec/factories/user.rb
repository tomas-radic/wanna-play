FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Lorem.word }
    password { 'any-supersafe-password' }
    password_confirmation { 'any-supersafe-password' }

    trait :blocked do 
      blocked true
    end
  end
end
