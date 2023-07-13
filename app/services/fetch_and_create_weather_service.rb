# frozen_string_literal: true

class FetchAndCreateWeatherService
  attr_reader :errors

  def initialize(latitude, longitude, start_date, end_date)
    @latitude = latitude
    @longitude = longitude
    @start_date = start_date
    @end_date = end_date
    @errors = []
  end

  def call
    response = WeatherService.new.fetch_weather(@latitude, @longitude, @start_date, @end_date)

    create_weathers_from_response(response)
  rescue StandardError => e
    @errors << e.message
    false
  end

  private

  def create_weathers_from_response(response)
    raise StandardError, response['reason'] if response['error']

    weathers = []

    response['daily']['time'].each_with_index do |date, index|
      max_temp = response['daily']['temperature_2m_max'][index]
      min_temp = response['daily']['temperature_2m_min'][index]

      next unless max_temp && min_temp

      weathers << OpenStruct.new({
        date: Date.parse(date),
        latitude: @latitude,
        longitude: @longitude,
        max_temperature: max_temp,
        min_temperature: min_temp
      })
    end

    SaveWeathersHistoryJob.perform_async(weathers)

    weathers
  end
end

# @latitude, @longitude, @start_date, @end_date = 52.520008, 13.404954, Date.today - 1.month, Date.today
