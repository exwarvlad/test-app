FactoryBot.define do
  factory :rate do
    value   { Kernel.rand 1..5 }
    post_id 1
  end
end
