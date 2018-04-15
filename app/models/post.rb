class Post < ApplicationRecord
  belongs_to :user
  belongs_to :ip_address
  has_many   :rates, dependent: :destroy

  validates :title, :description, presence: true
end
