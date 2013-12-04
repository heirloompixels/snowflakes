migration 9, :create_parks do
  up do
    create_table :parks do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :difficulty, DataMapper::Property::String, :length => 255
      column :groomed_or_cut, DataMapper::Property::String, :length => 255
      column :status, DataMapper::Property::String, :length => 255
      column :featured_terrain, DataMapper::Property::String, :length => 255
      column :night_operations, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :parks
  end
end
