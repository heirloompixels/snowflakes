migration 10, :add_fields_to_report do
  up do
    modify_table :reports do
      add_column :forecast, String
    end
  end

  down do
    modify_table :reports do
      drop_column :forecast
    end
  end
end
