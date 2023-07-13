# frozen_string_literal: true

class FetchAndCreateWeatherService
  def self.call(latitude, longitude, start_date, end_date)
    response = WeatherService.new.fetch_weather(latitude, longitude, start_date, end_date)

    create_weathers_from_response(response, latitude, longitude)
  end

  private
  def self.create_weathers_from_response(response, latitude, longitude)
    raise StandardError, response['reason'] if response['error']

    weathers = []

    weathers = response['daily']['time'].each_with_index.map do |date, index|
      max_temp = response['daily']['temperature_2m_max'][index]
      min_temp = response['daily']['temperature_2m_min'][index]

      next unless max_temp && min_temp

      {
        "date" => Date.parse(date).to_s,
        "latitude" => latitude,
        "longitude" => longitude,
        "max_temperature" => max_temp,
        "min_temperature" => min_temp
      }
    end.compact

    SaveWeathersHistoryJob.perform_async(weathers)

    weathers.map { |weather| OpenStruct.new(weather) }
  end
end