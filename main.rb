require_relative './lib/command_file_parser'
require_relative './lib/underground_system'

DEFAULT_COMMANDS_FILENAME = 'commands.txt'.freeze

def main
  commands_file = ARGV.first || DEFAULT_COMMANDS_FILENAME
  commands = CommandFileParser.load_commands(commands_file)

  tube = UndergroundSystem.new

  commands.each do |command_line|
    process_command(tube, command_line)
  end
end

def process_command(tube, command_line)
  case command_line.first
  when CommandFileParser::AVERAGE
    process_average_command(tube, command_line)
  else
    tube.send(*command_line)
  end
end

def process_average_command(tube, command_line)
  _, start_station, end_station = command_line
  avg = tube.get_average_time(start_station, end_station)
  puts "#{start_station},#{end_station},#{avg}"
end

main if __FILE__ == $PROGRAM_NAME
