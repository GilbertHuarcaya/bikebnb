class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :bikes, dependent: :destroy
  has_many :rentals, dependent: :destroy
  has_many :bikes, through: :rentals, dependent: :destroy
  has_one_attached :photo

  validates :firstname, :lastname, :phone_number, :city, presence: true
  validates :photo, presence: true
end
