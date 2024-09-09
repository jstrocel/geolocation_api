class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :ip_address
      t.string :url
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
