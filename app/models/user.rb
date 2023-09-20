class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :nickname, presence: true
  validates :nickname, uniqueness: true

  has_many :bathing_sites, dependent: :destroy_all
  has_many :favourites, dependent: :destroy_all
  has_many :reviews, dependent: :destroy_all
end
