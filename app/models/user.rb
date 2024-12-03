class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :pokemons
  has_many :bookings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :email, uniqueness: true

   def avatar_options = {
    "Ash" => "/app/assets/images/ash-pp.png",
    "Professor Oak" => "/app/assets/images/prof-oak-pp.jpeg",
    "Brock" => "/app/assets/images/brock-pp.jpg",
    "Hilda" => "/app/assets/images/hilda-pp.jpg"
  }.freeze

end
