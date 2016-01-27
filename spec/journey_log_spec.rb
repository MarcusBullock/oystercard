require 'journey_log'

describe JourneyLog do
  subject(:journey_log) {described_class.new (journey_klass)}
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}
  let(:journey_klass){ double('journey_klass')}
  let(:journey){ double(:journey) }

  before do
    allow(journey_klass).to receive(:new) {journey}
    allow(journey).to receive(:start_journey){:entry_station}
    allow(journey).to receive(:end_journey){:exit_station}
  end

  describe '#initialize' do

    it { is_expected.to respond_to(:journey_klass) }

    it 'journey_log is empty when started' do
      expect(journey_log.journey_log).to be_empty
    end
  end

  describe '#start_journey' do
    it 'starts a new journey' do
      expect(subject.start_journey(entry_station)).to eq journey
    end
  end

  describe '#current_journey' do

    it 'returns an incomplete journey' do
      subject.start_journey(entry_station)
      expect(subject.current_journey).to eq journey
    end

    it 'creates a new journey if not incomplete' do
      expect(subject.current_journey).to eq journey
    end
  end

  describe '#exit journey' do
    it ' should add an exit station to the current journey' do
      subject.start_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

end
