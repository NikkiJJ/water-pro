class Report < ApplicationRecord
  belongs_to :bathing_site

  validates :issue, presence: true
  validates :comment, presence: true
end
