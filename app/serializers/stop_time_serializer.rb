class StopTimeSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :arrival_time, :departure_time, :stop_id, :stop_sequence, :pickup_type, :drop_off_type
  has_one :trip

  def stop_id
    object.stop_str
  end

  def trip_id
    object.trip_str
  end

  # def include_trip?
  #   object.include_trip
  # end

end
