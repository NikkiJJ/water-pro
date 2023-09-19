class RemoveNullFromReport < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reports, :bathing_site_id, true
  end
end
