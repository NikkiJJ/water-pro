class AddConfirmationToReportsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :confirmation, :boolean, default: false
  end
end
