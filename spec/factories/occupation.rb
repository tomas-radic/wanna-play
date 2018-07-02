FactoryBot.define do
  factory :occupation do
    association :user
    association :court
    association :time_slot

    date { Date.today }
  end
end
