class AddStationIdToBathingSites < ActiveRecord::Migration[7.0]
  def change
    add_column :bathing_sites, :station_id, :integer
  end
end
