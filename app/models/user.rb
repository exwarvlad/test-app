class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :id_addresses, -> { distinct }, through: :posts, source: 'ip_address'

  validates :login, presence: true
end
