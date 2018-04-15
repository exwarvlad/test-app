class IpAddress < ApplicationRecord
  has_many :posts, dependent: :restrict_with_exception

  validates :ip, presence: true
end
