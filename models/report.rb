class Report
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :location_name, String
  property :primary_surface, String
  property :secondary_surface, String
  property :base, String
  property :base_range, String
  property :storm_total, String
  property :snow_over_night, String
  property :snow_12_hours, String
  property :snow_24_hours, String
  property :snow_48_hours, String
  property :snow_72_hours, String
  property :snow_4_days, String
  property :snow_5_days, String
  property :snow_7_days, String
  property :lodge_depth, String
  property :summit_depth, String
  property :snow_season_total, String
  property :weather_conditions, String
  property :temperature, String
  property :visibility, String
  property :wind_direction, String
  property :wind_speed, String
  property :resort_status, String
  property :open_time, String
  property :close_time, String
  property :night_open_time, String
  property :night_close_time, String
  property :total_acres_open, String
  property :days_hours_operation, String
  property :trails_open, String
  property :lifts_open, String
  property :notes, String
  property :news, String
  property :snow_sunday, String
  property :weather_sunday, String
  property :weather_monday, String
  property :weather_tuesday, String
  property :weather_wednesday, String
  property :weather_thursday, String
  property :weather_friday, String
  property :weather_saturday, String
  property :forecast, String


  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
end
