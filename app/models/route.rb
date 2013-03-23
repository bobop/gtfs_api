class Route < ActiveRecord::Base
  belongs_to :agency
  attr_accessible :route_id, :route_long_name, :route_short_name, :route_type
end