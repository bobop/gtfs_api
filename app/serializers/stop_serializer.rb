class StopSerializer < ActiveModel::Serializer
  attributes :id, :stop_id, :stop_code, :stop_name, :stop_lat, :stop_lon, :stop_url
  has_many :stop_times

  def include_stop_times?
    object.include_stop_times
  end

  def include_trip?
    object.include_trip
  end

  def stop_times
    stop_times = object.stop_times.order("departure_time ASC")
    if object.from_now
      stop_times = stop_times.where("departure_time > ?", Time.now)
    end
    if object.stop_time_limit.present?
      stop_times = stop_times.limit(object.stop_time_limit)
    end
    return stop_times
  end


end
