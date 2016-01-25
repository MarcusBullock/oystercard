require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) {double :station}

  describe '#initialize' do
    it 'initializes with a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money to card balance' do
      expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
    end

    it 'throws an exception if balance limit is exceeded' do
      message = "Max balance is £#{described_class::MAX_BALANCE}"
      expect{ oystercard.top_up(1 + described_class::MAX_BALANCE)}.to raise_error message
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts amount from card balance' do
      expect { oystercard.deduct 10 }.to change{ oystercard.balance }.by(-10)
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'sets card status to in journey' do
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'sets card status to not in journey' do
      # NOTE: refactor to before statement?
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard).not_to be_in_journey
    end
  end

end
