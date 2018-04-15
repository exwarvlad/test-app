FactoryBot.define do
  factory :user do
    login { Faker::Internet.user_name }
  end
end
