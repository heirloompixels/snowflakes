migration 8, :create_roads do
  up do
    create_table :roads do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :status, DataMapper::Property::String, :length => 255
      column :requirements, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :roads
  end
end
