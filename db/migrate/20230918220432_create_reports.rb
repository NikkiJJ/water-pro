class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :bathing_site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
