class UndergroundSystem
  def initialize
    @check_in_times = {}
    @journey_times = Hash.new { |hash, key| hash[key] = [] }
  end

  def check_in(id, station_name, time)
    return invalid_text unless valid_input?(id, station_name, time)

    @check_in_times[id] = [station_name, time]
  end

  def check_out(id, station_name, time)
    return invalid_text unless valid_input?(id, station_name, time)

    start_station, start_time = @check_in_times[id]
    @journey_times[[start_station, station_name]] << time - start_time
    @check_in_times.delete(id)
  end

  def get_average_time(start_station, end_station)
    return invalid_text if start_station.nil? || end_station.nil?

    journey_times = @journey_times[[start_station, end_station]]
    journey_times.empty? ? 0.0 : journey_times.sum / journey_times.size.to_f
  end

  private

  def valid_input?(id, station_name, time)
    id.is_a?(Integer) && !station_name.nil? && time.is_a?(Integer)
  end

  def invalid_text
    'Invalid Input'
  end
end
