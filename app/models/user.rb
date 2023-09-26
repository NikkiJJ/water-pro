class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :nickname, presence: true
  validates :nickname, uniqueness: true

  has_many :bathing_sites, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo
end
