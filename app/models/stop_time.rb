class StopTime < ActiveRecord::Base
  belongs_to :trip
  attr_accessible :arrival_time, :departure_time, :drop_off_type, :pickup_type, :stop_sequence, :stop_str, :trip_str
  attr_accessor :include_trip
end
