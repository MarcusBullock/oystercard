require 'oystercard'

describe Oystercard do
  subject(:oystercard){described_class.new}
      let (:station) {double(:station)}
      let (:station2) {double(:station)}

  describe '#initialize' do
    it 'checks that the card has a balance' do
      expect(subject.balance).to be 0
    end
  end

  describe '#topup' do
    it 'allows the user to add balance to their card' do
      expect{subject.topup(5)}.to change{subject.balance}.by 5
    end

    it 'throws an error if the new balance exceeds limit' do
      expect{subject.topup((Oystercard::MAX_LIMIT)+1)}.to raise_error "Exceeded max limit: #{Oystercard::MAX_LIMIT}"
    end
  end

  describe '#touch in and out' do
    before {subject.topup 1; subject.touch_in(station)}

    it 'show that user is in journey when touched in' do
      expect(subject).to be_in_journey
    end

    it 'show that user is not in journey when touched out' do
      subject.touch_out station
      expect(subject).not_to be_in_journey
    end
  end

  context 'requiring minimum balance' do

    it 'fails when touch-in is attempted with low balance' do
      expect{subject.touch_in(station)}.to raise_error 'low balance'
    end

    it 'deducts MIN_FARE on touch_out' do
      subject.topup(1)
      subject.touch_in station
      subject.touch_out station
      expect(subject.balance).to eq 0
    end
  end

  context 'adding entry and exit stations' do
    before {subject.topup(5); subject.touch_in(station)}
    it 'stores the entry station' do
      expect(subject.entry_station).to be station
    end

    it 'removes station on touchout' do
      subject.touch_out station
      expect(subject.entry_station).to be nil
    end

    it 'stores exit station' do
      subject.touch_out station
      expect(subject.exit_station).to be station
  end

    it 'removes exit station on touchin' do
      expect(subject.exit_station).to be nil
    end
  end

  context 'journey history' do
    it 'journey history is empty' do
      expect(subject.hist).to eq []
    end

    it 'adds one journey history per trip' do
      subject.topup(80)
      subject.touch_in station
      subject.touch_out station2
      expect(subject.hist).to eq [{station => station2}]
    end
  end
end
