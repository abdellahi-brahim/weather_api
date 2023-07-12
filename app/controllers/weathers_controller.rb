class WeathersController < ApplicationController
  before_action :set_dates_and_coordinates

  def index
    @weathers = Weather.where(
      latitude: @latitude,
      longitude: @longitude,
      date: @start_date..@end_date
    )

    if @weathers.empty? || @weathers.last.date > @start_date || @weathers.first.date < @end_date
      byebug
      if @weathers.empty?
        fetch_and_create_service = FetchAndCreateWeatherService.new(@latitude, @longitude, @start_date, @end_date)
      else
        fetch_and_create_service = FetchAndCreateWeatherService.new(@latitude, @longitude, @start_date, @weathers.first.date - 1.day) if @weathers.first.date > @start_date
        fetch_and_create_service = FetchAndCreateWeatherService.new(@latitude, @longitude, @weathers.last.date + 1.day, @end_date) if @weathers.last.date < @end_date
      end

      unless fetch_and_create_service&.call
        render json: { error: "Failed to fetch weather data: #{fetch_and_create_service&.errors}" }, status: :internal_server_error and return
      end
      
      @weathers = Weather.where(
        latitude: @latitude,
        longitude: @longitude,
        date: @start_date..@end_date
      )
    end
  end

  private

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
