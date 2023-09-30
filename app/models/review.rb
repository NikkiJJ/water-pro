class Review < ApplicationRecord
  has_many :report_reviews, dependent: :destroy
  belongs_to :bathing_site
  belongs_to :user
end
