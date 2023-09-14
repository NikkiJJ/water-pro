class Favourite < ApplicationRecord
  validates :user, uniqueness: { scope: :bathing_site }

  belongs_to :bathing_site
  belongs_to :user
end
