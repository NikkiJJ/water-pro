class AddCoordinatesToBathingSites < ActiveRecord::Migration[7.0]
  def change
    add_column :bathing_sites, :latitude, :float
    add_column :bathing_sites, :longitude, :float
  end
end
