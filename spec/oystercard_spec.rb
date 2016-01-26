require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) {double :station}

  describe '#initialize' do
    subject(:new_card) { described_class.new }
    it { is_expected.to respond_to(:balance, :entry_station) }
    it 'initializes with a balance of 0' do
      expect(new_card.balance).to eq(0)
    end
  end

  before(:each) do
    oystercard.top_up(10)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money to card balance' do
      expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
    end

    it 'throws an exception if balance limit is exceeded' do
      message = "Max balance is £#{described_class::MAX_BALANCE}"
      expect do
        oystercard.top_up(1 + described_class::MAX_BALANCE)
      end.to raise_error message
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'sets card status to in journey' do
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'stores entry station' do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

    context 'when balance is below minimum fare' do
      let(:empty_card) { described_class.new }
      it 'raises an error' do
        message = "Insufficient balance"
      expect{ empty_card.touch_in(station) }.to raise_error message
      end
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    before(:each) do
      oystercard.touch_in(station)
    end

    it 'sets card status to not in journey' do
      oystercard.touch_out(station)
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the journey fee from balance' do
      expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by (-described_class::MIN_FARE)
    end

    it 'resets entry station' do
      expect{ oystercard.touch_out(station) }.to change{ oystercard.entry_station }.from(station).to(nil)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?).with(0).arguments }

    it 'is initially not in journey' do
      expect(oystercard).not_to be_in_journey
    end

    context 'when touching in' do
      it 'returns true' do
        oystercard.touch_in(station)
        expect(oystercard).to be_in_journey
      end
    end

    context 'when touching out' do
      it 'returns false' do
        oystercard.touch_in(station)
        oystercard.touch_out(station)
        expect(oystercard).to_not be_in_journey
      end
    end
  end

end
