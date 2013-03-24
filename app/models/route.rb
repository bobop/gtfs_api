class Route < ActiveRecord::Base
  belongs_to :agency
  has_many :trips
  attr_accessible :route_id, :route_long_name, :route_short_name, :route_type
  attr_accessor :include_trips
end
