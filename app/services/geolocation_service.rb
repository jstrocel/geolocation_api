# app/services/geolocation_service.rb

class GeolocationService
  def initialize(ip_address = nil, url = nil)
    @ip_address = ip_address
    @url = url
  end

  def fetch_geolocation_data
    return nil if @ip_address.blank? && @url.blank?

    response = geolocation_data(@ip_address || @url)

    raise StandardError unless response.code == 200

    data = JSON.parse(response.body)
    puts data.inspect
    create_geolocation(data)

    { data:, success: true }
  rescue StandardError => e
    { error: "Failed to fetch geolocation data #{e.inspect}", success: false }
  end

  private

  def geolocation_data(address)
    HTTParty.get("https://api.ipstack.com/#{address}?access_key=#{ENV['GEOLOCATION_API_KEY']}")
  end

  def create_geolocation(data)
    Geolocation.create!(ip_address: data['ip'],
                        url: data['hostname'] || data['url'] || nil,
                        latitude: data['latitude'],
                        longitude: data['longitude'],
                        ip_type: data['type'],
                        continent_code: data['continent_code'],
                        country_name: data['country_name'],
                        region_code: data['region_code'],
                        region_name: data['region_code'],
                        city: data['city'],
                        zip: data['zip'],
                        msa: data['msa'],
                        dma: data['dma'],
                        radius: data['radius'],
                        ip_routing_type: data['ip_routing_type'],
                        connection_type: data['connection_type'],
                        geoname_id: data['location']['geoname_id'],
                        capital: data['location']['capital'],
                        languages: data['location']['languages'],
                        country_flag: data['location']['languages'],
                        country_flag_emoji: data['location']['county_flag_emoji'],
                        calling_code: data['location']['calling_code'],
                        is_eu: data['location']['is_eu'])
  end
end
