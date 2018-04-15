require 'active_record'
require 'activerecord-import'

TOTAL_POSTS_COUNT = 200_000
TOTAL_USERS_COUNT = 100
TOTAL_IPS_COUNT   = 50
start_time        = Time.zone.now
posts             = []
users             = []
ips               = []

Rails.logger.debug { "Start Time: #{start_time}" }
Thread.new do
  loop { sleep(5) && print('.') }
end

Rails.logger.debug { "Building #{TOTAL_USERS_COUNT} users." }
TOTAL_USERS_COUNT.times do
  users << FactoryBot.build(:user)
end

Rails.logger.debug { "Building #{TOTAL_IPS_COUNT} ip addresses." }
TOTAL_IPS_COUNT.times do
  ips << FactoryBot.build(:ip_address)
end

Rails.logger.debug { "Building #{TOTAL_POSTS_COUNT} posts." }
TOTAL_POSTS_COUNT.times do |i|
  user_id         = Kernel.rand 1..TOTAL_USERS_COUNT
  ip_address_id   = Kernel.rand 1..TOTAL_IPS_COUNT
  post            = FactoryBot.build(:post, user_id: user_id, ip_address_id: ip_address_id)
  expected_random = ->(n) { (n % Kernel.rand(1..50)).zero? }

  post.rates.build(value: Kernel.rand(1..5)) if expected_random.call(i)
  posts << post
end

User.import      users, validate: false
IpAddress.import ips,   validate: false
Post.import      posts, validate: false, recursive: true

end_time = Time.zone.now
Rails.logger.debug { "\n\n\n-------------\nTotal result: #{(end_time - start_time)} seconds." }
