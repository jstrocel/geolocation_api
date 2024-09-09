# app/controllers/api/v1/geolocations_controller.rb

class Api::V1::GeolocationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @geolocations = Geolocation.all
    render json: @geolocations, status: :ok
  end

  def show
    @geolocation = Geolocation.find(params[:id])
    render json: @geolocation
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not Found' }, status: :not_found
  end

  def create
    service = GeolocationService.new(geolocation_params[:ip_address], geolocation_params[:url])

    data = service.fetch_geolocation_data
    raise StandardError unless data[:success] == true

    render json: data, status: :created
  rescue StandardError => e
    render json: { error: "Failed to create geolocation: #{e.inspect}", data: }, status: :unprocessable_entity
  end

  def destroy
    @geolocation = Geolocation.find(params[:id])
    render json: {}, status: :no_content if @geolocation.destroy
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not Found' }, status: :not_found
  end

  private

  def geolocation_params
    params.require(:geolocation).permit(:id, :ip_address, :url)
  end
end
