class Trip < ActiveRecord::Base
  belongs_to :route
  belongs_to :calendar
  attr_accessible :service_id, :trip_headsign, :trip_id
end