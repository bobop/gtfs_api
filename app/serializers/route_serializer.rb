class RouteSerializer < ActiveModel::Serializer
  attributes :id, :route_id, :agency_id, :route_short_name, :route_long_name, :route_type
  has_many :trips

  def agency_id
    object.agency.agency_id
  end

  def include_trips?
    object.include_trips
  end
end
