class StopTimeSerializer < ActiveModel::Serializer
  attributes :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence, :pickup_type, :drop_off_type
end
