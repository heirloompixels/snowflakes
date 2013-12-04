migration 6, :add_weather_to_reports do
  up do
    modify_table :reports do
      add_column :snow_sunday, String
    add_column :weather_sunday, String
    add_column :weather_monday, String
    add_column :weather_tuesday, String
    add_column :weather_wednesday, String
    add_column :weather_thursday, String
    add_column :weather_friday, String
    add_column :weather_saturday, String
    end
  end

  down do
    modify_table :reports do
      drop_column :snow_sunday
    drop_column :weather_sunday
    drop_column :weather_monday
    drop_column :weather_tuesday
    drop_column :weather_wednesday
    drop_column :weather_thursday
    drop_column :weather_friday
    drop_column :weather_saturday
    end
  end
end
