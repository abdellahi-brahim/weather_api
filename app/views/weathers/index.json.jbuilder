# frozen_string_literal: true

json.array! @weathers do |weather|
  json.date weather.date
  json.latitude weather.latitude
  json.longitude weather.longitude
  json.max_temperature weather.max_temperature
  json.min_temperature weather.min_temperature
end
