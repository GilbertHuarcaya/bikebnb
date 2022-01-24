class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :bike

  validates :bike, :user, presence: true
end
