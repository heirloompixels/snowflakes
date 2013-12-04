migration 1, :create_trails do
  up do
    create_table :trails do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :status, DataMapper::Property::String, :length => 255
      column :groomed, DataMapper::Property::String, :length => 255
      column :snow_making, DataMapper::Property::String, :length => 255
      column :featured_terrain, DataMapper::Property::String, :length => 255
      column :night_operation, DataMapper::Property::String, :length => 255
      column :difficulty, DataMapper::Property::String, :length => 255
      column :type, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :trails
  end
end
