class CreateCalendarDates < ActiveRecord::Migration
  def change
    create_table :calendar_dates do |t|
      t.references :calendar
      t.string :service_id
      t.date :date
      t.integer :exception_type

      t.timestamps
    end
    add_index :calendar_dates, :calendar_id
  end
end
