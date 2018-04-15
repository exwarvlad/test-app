FactoryBot.define do
  factory :ip_address do
    ip { Faker::Internet.ip_v4_address }
  end
end
