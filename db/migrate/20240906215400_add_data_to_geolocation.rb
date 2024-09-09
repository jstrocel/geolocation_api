class AddDataToGeolocation < ActiveRecord::Migration[7.1]
  def change
    add_column :geolocations, :ip_type, :string
    add_column :geolocations, :continent_code, :string
    add_column :geolocations, :continent_name, :string
    add_column :geolocations, :country_code, :string
    add_column :geolocations, :country_name, :string
    add_column :geolocations, :region_code, :string
    add_column :geolocations, :region_name, :string
    add_column :geolocations, :city, :string
    add_column :geolocations, :zip, :string
    add_column :geolocations, :msa, :string
    add_column :geolocations, :dma, :string
    add_column :geolocations, :radius, :string
    add_column :geolocations, :ip_routing_type, :string
    add_column :geolocations, :connection_type, :string
    add_column :geolocations, :geoname_id, :integer
    add_column :geolocations, :capital, :string
    add_column :geolocations, :languages, :string
    add_column :geolocations, :country_flag, :string
    add_column :geolocations, :country_flag_emoji, :string
    add_column :geolocations, :calling_code, :string
    add_column :geolocations, :is_eu, :boolean
  end
end
