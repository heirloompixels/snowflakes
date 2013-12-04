migration 2, :create_lifts do
  up do
    create_table :lifts do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :persons, DataMapper::Property::String, :length => 255
      column :type, DataMapper::Property::String, :length => 255
      column :status, DataMapper::Property::String, :length => 255
      column :night_status, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :lifts
  end
end
