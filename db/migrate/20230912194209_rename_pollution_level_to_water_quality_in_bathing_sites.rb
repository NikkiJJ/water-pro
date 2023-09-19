class RenamePollutionLevelToWaterQualityInBathingSites < ActiveRecord::Migration[7.0]
  def change
    rename_column :bathing_sites, :pollution_level, :water_quality
  end
end
