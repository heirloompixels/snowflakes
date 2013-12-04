migration 7, :add_times_to_reports do
  up do
    modify_table :reports do
      add_column :created_at, DateTime
    add_column :created_on, Date
    add_column :updated_at, DateTime
    add_column :updated_on, Date
    end
  end

  down do
    modify_table :reports do
      drop_column :created_at
    drop_column :created_on
    drop_column :updated_at
    drop_column :updated_on
    end
  end
end
