class AddWebUrlToBathingSites < ActiveRecord::Migration[7.0]
  def change
    add_column :bathing_sites, :web_res_image_url, :string
  end
end
