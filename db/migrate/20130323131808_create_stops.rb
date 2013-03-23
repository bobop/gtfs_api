class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :stop_id
      t.string :stop_code
      t.string :stop_name
      t.float :stop_lat
      t.float :stop_lon
      t.text :stop_url

      t.timestamps
    end
  end
end
