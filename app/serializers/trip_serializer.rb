class TripSerializer < ActiveModel::Serializer
  attributes :route_id, :service_id, :trip_id, :trip_headsign
  has_one :calendar

  def route_id
    object.route_str
  end

  def include_calendar?
    object.include_calendar
  end
end
