class Bike < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :description, :model, :price, presence: true
  validates :description, length: { minimum: 6 }
  validates :user, presence: true
  validates :photo, presence: true
  validates :address, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_address,
                  against: [:address],
                  using: {
                    tsearch: { prefix: true },
                  }
end
