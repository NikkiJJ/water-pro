class BathingSite < ApplicationRecord
  belongs_to :user, optional: true

  has_many :reviews
  has_many :favourites

  geocoded_by :region
  after_validation :geocode, if: :will_save_change_to_region?
end
