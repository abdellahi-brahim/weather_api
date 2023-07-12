# frozen_string_literal: true

class WeatherService
  def connection
    Faraday.new(url: 'https://archive-api.open-meteo.com/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_weather(latitude, longitude, start_date, end_date)
    response = connection.get do |req|
      req.url url_with_query(latitude, longitude, start_date, end_date)
    end

    JSON.parse(response.body)
  end

  def url_with_query(latitude, longitude, start_date, end_date)
    parameters = {
      'latitude' => latitude,
      'longitude' => longitude,
      'start_date' => start_date,
      'end_date' => end_date,
      'daily' => 'temperature_2m_max,temperature_2m_min',
      'timezone' => Rails.application.config.time_zone
    }

    "/v1/archive?#{parameters.to_query}"
  end
end
