class ReportReview < ApplicationRecord
  validates :issue, presence: true
  validates :comment, presence: true, length: { minimum: 5, maximum: 1000 }

end
