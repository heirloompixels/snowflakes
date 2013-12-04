migration 11, :add_park_to_report do
  up do
    modify_table :reports do
      add_column :park, String
    end
  end

  down do
    modify_table :reports do
      drop_column :park
    end
  end
end
