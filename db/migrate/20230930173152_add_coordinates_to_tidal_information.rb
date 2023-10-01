class AddCoordinatesToTidalInformation < ActiveRecord::Migration[7.0]
  def change
    add_column :tidal_informations, :latitude, :float
    add_column :tidal_informations, :longitude, :float
  end
end
