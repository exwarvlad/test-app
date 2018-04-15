FactoryBot.define do
  factory :post do
    title         { Faker::Book.title }
    description   { Faker::Lovecraft.sentences(2).join ' ' }
    ip_address_id 1
    user_id       1
  end
end
