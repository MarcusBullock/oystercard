require 'journey'

describe Journey do

  subject(:journey){described_class.new}
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}

  describe '#start_journey' do

    it 'starts with an entry station' do
      expect(subject.start_journey(entry_station)).to eq entry_station
    end
  end

  describe '#end_journey' do

    it 'ends a journey' do
      expect(subject.end_journey(exit_station)).to eq exit_station
    end
  end

  describe '#calculate_fare' do

    it 'calculates a fare' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject.calculate_fare).to eq Oystercard::MIN_FARE
    end

    it 'gives a penalty fare when you touch in twice' do
      2.times{subject.start_journey(entry_station)}
      expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#completed?' do

    it 'tells us a journey is completed' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject).to be_completed
    end

    it 'tells us a journey is not completed' do
      subject.start_journey(entry_station)
      expect(subject).not_to be_completed
    end
  end

end
