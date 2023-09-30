class AddColumnsToReportedReviewsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :report_reviews, :issue, :string, null: true
    add_column :report_reviews, :comment, :text, null: true
  end
end
