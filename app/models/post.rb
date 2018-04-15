class Post < ApplicationRecord
  belongs_to :user
  belongs_to :ip_address
  has_many   :rates, dependent: :destroy

  scope :top, -> { order(average_rate: :desc) }

  validates :title, :description, presence: true
end
