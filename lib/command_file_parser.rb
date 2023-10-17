module CommandFileParser
  CHECK_IN = 'check_in'.freeze
  CHECK_OUT = 'check_out'.freeze
  AVERAGE = 'get_average'.freeze

  def self.parse_command_line(line_str)
    line = line_str.strip.split(',')

    case line.first
    when CHECK_IN, CHECK_OUT
      parse_checkin_checkout(line)
    when AVERAGE
      line
    else
      nil
    end
  end

  def self.load_commands(filename)
    IO.readlines(filename)
      .map(&method(:parse_command_line))
      .compact
  end

  def self.parse_checkin_checkout(line)
    command, id, station_name, time = line
    [command, id.to_i, station_name, time.to_i]
  end
end
