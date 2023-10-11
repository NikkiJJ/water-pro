class BathingSite < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reports, dependent: :destroy

  geocoded_by :full_site_name_or_region

  after_validation :geocode, if: ->(obj) { obj.full_site_name_or_region.present? && obj.latitude.blank? && obj.longitude.blank? }

  include PgSearch::Model

  pg_search_scope :search_by_site_name_and_region, against: {
    site_name: 'A',
    region: 'B'
  }, using: {
    tsearch: { prefix: true }
  }

  def full_site_name_or_region
    if site_name.present?
      "#{site_name}, #{region}, United Kingdom"
    else
      region
    end
  end
end
