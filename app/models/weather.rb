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
class Weather < ApplicationRecord
  default_scope { order(date: :desc) }
end
