class AddAboutToBathingSites < ActiveRecord::Migration[7.0]
  def change
    add_column :bathing_sites, :site_info, :string
  end
end
