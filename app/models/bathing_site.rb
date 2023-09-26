class BathingSite < ApplicationRecord
  belongs_to :user, optional: true

  # has_many :users, through: :favourites
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reports, dependent: :destroy

  geocoded_by :region
  after_validation :geocode, if: :will_save_change_to_region?
  include PgSearch::Model

  pg_search_scope :search_by_site_name_and_region, against: {
    site_name: 'A',
    region: 'B'
  }, using: {
    tsearch: { prefix: true }
  }
end
