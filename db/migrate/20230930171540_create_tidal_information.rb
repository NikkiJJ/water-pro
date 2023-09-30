class CreateTidalInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :tidal_informations do |t|
      t.integer :station_id
      t.string :station_name
      t.string :country
      t.boolean :continuous_heights_available
      t.string :footnote

      t.timestamps
    end
  end
end
