require 'rails_helper'
require 'httparty'

RSpec.describe Api::V1::GeolocationsController, type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:user)
    login
    @auth_params = get_auth_params_from_login_response_headers(response)
  end

  describe 'GET index' do
    it 'returns all geolocations' do
      geolocations = create_list(:geolocation, 3)
      request = get api_v1_geolocations_path, headers: @auth_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe 'GET show' do
    it 'returns a single geolocation with valid params' do
      geolocation = create(:geolocation)
      request = get api_v1_geolocation_path(geolocation), headers: @auth_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(geolocation.id)
    end

    it 'returns an error when the geolocation is not fond' do
      request = get api_v1_geolocation_path(-1), headers: @auth_params

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST create' do
    let!(:mock_response) do
      instance_double(HTTParty::Response,
                      body: { ip: '134.201.250.155',
                              latitude: 34.0655517578125,
                              longitude: -118.24053955078125,
                              location: {
                                geoname_id: 5_368_361,
                                capital: 'Washington D.C.',
                                languages: [
                                  { code: 'en',
                                    name: 'English',
                                    native: 'English' }
                                ],
                                country_flag: 'https://assets.ipstack.com/flags/us.svg',
                                country_flag_emoji: '🇺🇸',
                                country_flag_emoji_unicode: 'U+1F1FA U+1F1F8',
                                calling_code: '1',
                                is_eu: false
                              } }.to_json, code: 200)
    end

    let!(:invalid_response) do
      instance_double(HTTParty::Response, code: 404)
    end

    it 'creates a new geolocation with valid params' do
      expect(HTTParty).to receive(:get).and_return(mock_response)
      post api_v1_geolocations_path,
           params: { geolocation: { ip_address: '134.201.250.155' } }, headers: @auth_params
      expect(response).to have_http_status(:created)
      db_geolocation = Geolocation.find_by(ip_address: '134.201.250.155')

      expect(db_geolocation).to be_present
      expect(db_geolocation.latitude).not_to be_nil
      expect(db_geolocation.longitude).not_to be_nil
    end

    it 'returns an error for invalid params' do
      post api_v1_geolocations_path, params: { geolocation: { id: -1 } },
                                     headers: @auth_params

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns an error for invalid params' do
      expect(HTTParty).to receive(:get).and_return(invalid_response)
      post api_v1_geolocations_path,
           params: { geolocation: { ip_address: '134.201.250.155' } }, headers: @auth_params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes a geolocation' do
      geolocation = create(:geolocation)

      delete api_v1_geolocation_path(geolocation), headers: @auth_params

      expect(response).to have_http_status(:no_content)
    end

    it 'returns an error for a non-existent geolocation' do
      delete api_v1_geolocation_path(id: -1), headers: @auth_params

      expect(response).to have_http_status(:not_found)
    end
  end

  def login
    post user_session_path, params: { email: @current_user.email, password: 'password' }.to_json,
                            headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
  end
end
