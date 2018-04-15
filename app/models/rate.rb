class Rate < ApplicationRecord
  belongs_to :post

  validates :value, presence: true
end
