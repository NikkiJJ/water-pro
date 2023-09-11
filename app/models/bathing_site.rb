class BathingSite < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reviews
  has_many :favourites
end
