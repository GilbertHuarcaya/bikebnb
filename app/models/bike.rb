class Bike < ApplicationRecord
  belongs_to :user
  has_many :rentals
  has_one_attached :photo

  validates :description, :model, :price, presence: true
  validates :description, length: { minimum: 6 }
  validates :user, presence: true
end
