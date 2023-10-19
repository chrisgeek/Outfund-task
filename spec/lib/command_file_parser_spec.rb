require 'rspec'
require './lib/command_file_parser'

RSpec.describe CommandFileParser do
  describe '.parse_command_line' do
    it 'parses check-in commands' do
      line = 'check_in,45,StationA,10'
      result = CommandFileParser.parse_command_line(line)
      expect(result).to eq(['check_in', 45, 'StationA', 10])
    end

    it 'parses check-out commands' do
      line = 'check_out,32,StationB,20'
      result = CommandFileParser.parse_command_line(line)
      expect(result).to eq(['check_out', 32, 'StationB', 20])
    end

    it 'parses get_average commands' do
      line = 'get_average,StationA,StationB'
      result = CommandFileParser.parse_command_line(line)
      expect(result).to eq(%w[get_average StationA StationB])
    end

    it 'returns nil for invalid commands' do
      line = 'invalid_command,45,StationA,10'
      result = CommandFileParser.parse_command_line(line)
      expect(result).to be_nil
    end
  end

  describe '.load_commands' do
    let(:filename) { 'test_commands.txt' }

    before do
      allow(IO).to receive(:readlines).with(filename).and_return([
        'check_in,45,StationA,10',
        'check_out,32,StationB,20',
        'get_average,StationA,StationB',
        'invalid_command,45,StationA,10'
      ])
    end

    it 'loads and parses valid commands' do
      result = CommandFileParser.load_commands(filename)
      expect(result).to eq([
        ['check_in', 45, 'StationA', 10],
        ['check_out', 32, 'StationB', 20],
        ['get_average', 'StationA', 'StationB']
      ])
    end

    it 'skips invalid commands' do
      result = CommandFileParser.load_commands(filename)
      expect(result).to_not include(nil)
    end
  end
end
