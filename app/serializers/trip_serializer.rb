class TripSerializer < ActiveModel::Serializer
  attributes :route_id, :service_id, :trip_id, :trip_headsign

  def route_id
    object.route_str
  end
end
