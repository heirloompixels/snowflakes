migration 4, :create_reports do
  up do
    create_table :reports do
      column :id, Integer, :serial => true
      column :location_name, DataMapper::Property::String, :length => 255
      column :primary_surface, DataMapper::Property::String, :length => 255
      column :secondary_surface, DataMapper::Property::String, :length => 255
      column :base, DataMapper::Property::String, :length => 255
      column :base_range, DataMapper::Property::String, :length => 255
      column :storm_total, DataMapper::Property::String, :length => 255
      column :snow_over_night, DataMapper::Property::String, :length => 255
      column :snow_12_hours, DataMapper::Property::String, :length => 255
      column :snow_24_hours, DataMapper::Property::String, :length => 255
      column :snow_48_hours, DataMapper::Property::String, :length => 255
      column :snow_72_hours, DataMapper::Property::String, :length => 255
      column :snow_4_days, DataMapper::Property::String, :length => 255
      column :snow_5_days, DataMapper::Property::String, :length => 255
      column :snow_7_days, DataMapper::Property::String, :length => 255
      column :lodge_depth, DataMapper::Property::String, :length => 255
      column :summit_depth, DataMapper::Property::String, :length => 255
      column :snow_season_total, DataMapper::Property::String, :length => 255
      column :weather_conditions, DataMapper::Property::String, :length => 255
      column :temperature, DataMapper::Property::String, :length => 255
      column :visibility, DataMapper::Property::String, :length => 255
      column :wind_direction, DataMapper::Property::String, :length => 255
      column :wind_speed, DataMapper::Property::String, :length => 255
      column :resort_status, DataMapper::Property::String, :length => 255
      column :open_time, DataMapper::Property::String, :length => 255
      column :close_time, DataMapper::Property::String, :length => 255
      column :night_open_time, DataMapper::Property::String, :length => 255
      column :night_close_time, DataMapper::Property::String, :length => 255
      column :total_acres_open, DataMapper::Property::String, :length => 255
      column :days_hours_operation, DataMapper::Property::String, :length => 255
      column :trails_open, DataMapper::Property::String, :length => 255
      column :lifts_open, DataMapper::Property::String, :length => 255
      column :notes, DataMapper::Property::String, :length => 255
      column :news, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :reports
  end
end
