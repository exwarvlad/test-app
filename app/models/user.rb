class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :id_addresses, through: :posts

  validates :login, presence: true
end
