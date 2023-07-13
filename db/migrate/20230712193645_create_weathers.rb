# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.float :latitude
      t.float :longitude
      t.date :date
      t.integer :max_temperature
      t.integer :min_temperature

      t.timestamps
    end
    
    add_index :weathers, [:latitude, :longitude, :date], unique: true
  end
end
