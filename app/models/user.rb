class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :pokemons, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # get bookings from other users for the current user
  has_many :received_bookings, through: :pokemons, source: :bookings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :email, uniqueness: true
end
