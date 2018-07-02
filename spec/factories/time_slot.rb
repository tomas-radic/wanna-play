require 'securerandom'

FactoryBot.define do
  factory :time_slot do
    label_begin_time { SecureRandom.hex }
    label_end_time { SecureRandom.hex }
  end
end
