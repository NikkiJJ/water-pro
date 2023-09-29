class ReportReview < ApplicationRecord
  validates :issue, presence: true
  validates :comment, presence: true, length: { minimum: 3, maximum: 1000 }

  belongs_to :review
end
