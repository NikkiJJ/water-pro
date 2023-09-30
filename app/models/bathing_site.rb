class BathingSite < ApplicationRecord
  belongs_to :user, optional: true

  # has_many :users, through: :favourites
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reports, dependent: :destroy

  geocoded_by :full_site_name
  after_validation :geocode, if: :will_save_change_to_site_name?
  include PgSearch::Model

  pg_search_scope :search_by_site_name_and_region, against: {
    site_name: 'A',
    region: 'B'
  }, using: {
    tsearch: { prefix: true }
  }

  def full_site_name
    "#{site_name}, #{region}"
  end
end
