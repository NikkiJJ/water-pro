class Favourite < ApplicationRecord
  belongs_to :bathing_site
  belongs_to :user
end
