class CreateStopTimes < ActiveRecord::Migration
  def change
    create_table :stop_times do |t|
      t.references :trip
      t.string :trip_str
      t.time :arrival_time
      t.time :departure_time
      t.references :stop
      t.string :stop_str
      t.integer :stop_sequence
      t.integer :pickup_type
      t.integer :drop_off_type

      t.timestamps
    end
    add_index :stop_times, :trip_id
    add_index :stop_times, :stop_id
  end
end
