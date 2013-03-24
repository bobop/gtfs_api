class StopSerializer < ActiveModel::Serializer
  attributes :id, :stop_id, :stop_code, :stop_name, :stop_lat, :stop_lon, :stop_url
  has_many :stop_times

  def include_stop_times?
    object.include_stop_times
  end


end
