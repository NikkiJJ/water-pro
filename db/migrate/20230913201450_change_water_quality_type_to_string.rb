class ChangeWaterQualityTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :bathing_sites, :water_quality, :string
  end
end
