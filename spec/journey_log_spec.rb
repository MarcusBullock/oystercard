require 'journey_log'

describe JourneyLog do
  subject(:journey_log) {described_class.new}
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}

  describe 'start journey log' do
    it 'journey_log is empty when started' do
      expect(journey_log.journey_log).to be_empty
    end
  end

  describe '#start_journey' do
    it 'starts a new journey' do
      expect(subject.start_journey(entry_station)).to include entry_station
    end
  end

  describe '#current_journey' do
    it 'returns an incomplete journey' do
      subject.start_journey(entry_station)
      expect(subject.current_journey).to include entry_station
    end

    it 'creates a new journey if not incomplete' do

    end

  end

end
