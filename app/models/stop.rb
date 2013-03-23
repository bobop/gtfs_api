class Stop < ActiveRecord::Base
  attr_accessible :stop_code, :stop_id, :stop_lat, :stop_lon, :stop_name, :stop_url
end
