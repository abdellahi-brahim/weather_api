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
  end
end
