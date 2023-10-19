require './lib/underground_system'
require 'byebug'

RSpec.describe UndergroundSystem do
  let(:tube) { UndergroundSystem.new }
  let(:invalid_input) { 'Invalid Input' }

  describe 'valid inputs' do
    it 'should return average with valid inputs' do
      tube.check_in(45, 'Layton', 3)
      tube.check_in(32, 'Paradise', 8)
      tube.check_out(45, 'Waterloo', 15)
      tube.check_out(32, 'Cambridge', 22)
      ans = tube.get_average_time('Paradise', 'Cambridge')
      expect(ans).to eq 14
    end
  end

  describe '#check_in' do
    it 'should return invalid_input if the id, station_name, or time is nil' do
      expect(tube.check_in(nil, 'Leyton', 3)).to eq(invalid_input)
      expect(tube.check_in(45, nil, 3)).to eq(invalid_input)
      expect(tube.check_in(45, 'Leyton', nil)).to eq(invalid_input)
    end

    it 'should check in the customer at the given station at the given time' do
      expect(tube.check_in(45, 'Layton', 3)).to eq(['Layton', 3])
    end
  end

  describe '#check_out' do
    it 'should return "Invalid Input" if the id, station_name, or time is nil' do
      expect(tube.check_out('10', 'Waterloo', 15)).to eq(invalid_input)
      expect(tube.check_out(45, nil, 15)).to eq(invalid_input)
      expect(tube.check_out(45, 'Waterloo', 'invalid')).to eq(invalid_input)
    end

    it 'should check out the customer from the given station at the given time' do
      tube.check_in(45, 'Leyton', 3)
      tube.check_out(45, 'Waterloo', 15)

      journey_times = tube.instance_variable_get(:@journey_times)
      expect(journey_times).to eq({ ['Leyton', 'Waterloo'] => [12] })
    end
  end

  describe '#get_average_time' do
    it 'should return "Invalid Input" if the start_station or end_station is nil' do
      expect(tube.get_average_time(nil, 'Waterloo')).to eq(invalid_input)
      expect(tube.get_average_time('Leyton', nil)).to eq(invalid_input)
    end

    it 'should return the average journey time between the given stations' do
      tube.check_in(45, 'Leyton', 10)
      tube.check_out(45, 'Waterloo', 15)

      expect(tube.get_average_time('Leyton', 'Waterloo')).to eq(5)
    end

    it 'returns 0 for stations with no recorded travel times' do
      expect(tube.get_average_time('Station X', 'Station Y')).to eq(0.0)
    end
  end
end
