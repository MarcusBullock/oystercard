require 'journey'

describe Journey do
  subject(:journey) {described_class.new(entry_station)}
  let(:entry_station) { double :entry_station, :name => 'Euston', :zone => 1 }
  let(:exit_station) { double :exit_station, :name => 'Camden', :zone => 2 }
  let(:oystercard)  { double :oystercard}

  context 'at journey initialize' do

    describe 'initialize' do
      it 'should have an entry station' do
        expect(journey.entry_station).to be_truthy
      end
    end

    describe 'journey_complete?' do
      it 'checks journey is not complete' do
        expect(journey.complete_journey?).to eq false
      end
    end
  end


  context 'at journey end' do
    describe 'exit' do
      it 'returns itself' do
        expect(journey.exit(exit_station)).to eq journey
      end
    end

    before do
      journey.exit(exit_station)
    end

    describe 'journey_complete?' do
      it 'checks journey is complete' do
        expect(journey.complete_journey?).to eq true
      end
    end

    describe 'exit_station' do
      it 'should have an exit station stored' do
        expect(journey.exit_station).to be_truthy
      end
    end
  end

  context 'fare is calculated' do
    describe '#fare' do
      it 'returns the correct fare' do
        journey.exit(exit_station)
        expect(journey.fare).to eq Journey::FARE_MIN + (entry_station.zone - exit_station.zone).abs * Journey::ZONE_FARE
      end
    end

    describe '#fare' do
      it 'returns penalty fare when no entry or exit station is logged' do
        expect(journey.fare).to eq(Journey::PENALTY_FARE)
      end
    end

  end


end
