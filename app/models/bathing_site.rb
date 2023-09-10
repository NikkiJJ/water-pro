class BathingSite < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favourites
end
