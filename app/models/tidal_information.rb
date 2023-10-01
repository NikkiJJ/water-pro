class TidalInformation < ApplicationRecord
  geocoded_by :station_name
  after_validation :geocode
end
