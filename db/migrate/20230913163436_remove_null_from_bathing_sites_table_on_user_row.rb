class RemoveNullFromBathingSitesTableOnUserRow < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bathing_sites, :user_id, true
  end
end
