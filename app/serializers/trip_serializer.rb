class TripSerializer < ActiveModel::Serializer
  attributes :id, :route_id, :service_id, :trip_id, :trip_headsign
  has_one :calendar
  has_one :route

  def route_id
    object.route_str
  end

  def include_calendar?
    object.include_calendar
  end

  # def include_route?
  #   object.include_route
  # end
end
