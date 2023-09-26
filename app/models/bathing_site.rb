class BathingSite < ApplicationRecord
  belongs_to :user, optional: true

  # has_many :users, through: :favourites
  has_many :reviews
  has_many :favourites

  geocoded_by :region
  after_validation :geocode, if: :will_save_change_to_region?
  include PgSearch::Model

  pg_search_scope :search_by_site_name, against: :site_name, using: {
    tsearch: { prefix: true }
  }
end
