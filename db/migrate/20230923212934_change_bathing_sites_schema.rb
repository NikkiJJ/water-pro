class ChangeBathingSitesSchema < ActiveRecord::Migration[7.0]
  def change
    add_column :bathing_sites, :eubwid, :string
  end
end
