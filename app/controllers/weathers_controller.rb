# frozen_string_literal: true

class WeathersController < ApplicationController
  before_action :set_dates_and_coordinates

  def index
    @weathers = Weather.where(
      latitude: @latitude,
      longitude: @longitude,
      date: @start_date..@end_date
    )

    return unless day_missing? || @weathers.empty?

    FetchAndCreateWeatherService.new(
      @latitude,
      @longitude,
      @start_date,
      @end_date
    ).call
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def day_missing?
    @weathers.count != (@end_date - @start_date).to_i + 1
  end

  def set_dates_and_coordinates
    city = weather_params[:city]
    geocoded_data = ::Geocoder.search(city).first

    if geocoded_data
      @latitude = geocoded_data.latitude
      @longitude = geocoded_data.longitude
    else
      render json: { error: "Failed to find the city: #{city}" }, status: :not_found and return
    end

    @start_date = Date.parse(weather_params[:start_date])
    @end_date = Date.parse(weather_params[:end_date])
  end

  def weather_params
    params.permit(:city, :start_date, :end_date)
  end
end
