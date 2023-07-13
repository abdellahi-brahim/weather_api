class SaveWeathersHistoryJob
  include Sidekiq::Job

  def perform(weather_history)
    weather_history.each do |weather|
       Weather.find_or_create_by!(
        date: weather.date,
        latitude: weather.latitude,
        longitude: weather.longitude
       ) do |weather_record|
          weather_record.max_temperature = weather.max_temperature
          weather_record.min_temperature = weather.min_temperature
       end
    end
  end
end
