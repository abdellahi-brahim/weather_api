# frozen_string_literal: true

# == Schema Information
#
# Table name: weathers
#
#  id              :integer          not null, primary key
#  date            :date
#  latitude        :float
#  longitude       :float
#  max_temperature :integer
#  min_temperature :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_weathers_on_latitude_and_longitude_and_date  (latitude,longitude,date) UNIQUE
#
class Weather < ApplicationRecord
  default_scope { order(date: :desc) }
end
