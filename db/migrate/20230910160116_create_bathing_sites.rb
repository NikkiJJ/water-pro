class CreateBathingSites < ActiveRecord::Migration[7.0]
  def change
    create_table :bathing_sites do |t|
      t.integer :pollution_level
      t.string :site_name
      t.string :tide
      t.string :region
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
