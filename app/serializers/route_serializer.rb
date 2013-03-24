class RouteSerializer < ActiveModel::Serializer
  attributes :id, :route_id, :agency_id, :route_short_name, :route_long_name, :route_type
  has_many :trips
  has_one :agency

  def agency_id
    object.agency.agency_id
  end

  def include_trips?
    object.include_trips
  end

  def include_agency?
    object.include_agency
  end
end
