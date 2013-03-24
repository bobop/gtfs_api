class Stop < ActiveRecord::Base
  has_many :stop_times
  attr_accessible :stop_code, :stop_id, :stop_lat, :stop_lon, :stop_name, :stop_url
  attr_accessor :include_stop_times
end
