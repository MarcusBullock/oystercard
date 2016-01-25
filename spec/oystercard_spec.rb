require 'oystercard'

describe Oystercard do
  subject(:oystercard){described_class.new}

  describe '#initialize' do
    it 'checks that the card has a balance' do
      expect(subject.balance).to be 0
    end

    it 'allows the user to set the initial balance' do
      expect(Oystercard.new(5).balance).to eq 5
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

  # describe '#deduct' do
  #   it 'allows the user to deduct a specified fare from the balance' do
  #     expect{subject.deduct(5)}.to change{subject.balance}.by -5
  #   end
  # end

  describe '#touch in and out' do
    before {subject.topup 5; subject.touch_in}

    it 'show that user is in journey when touched in' do
      expect(subject).to be_in_journey
    end

    it 'show that user is not in journey when touched out' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  context 'requiring minimum balance' do

    it 'fails when touch-in is attempted with low balance' do
      expect{subject.touch_in}.to raise_error 'low balance'
    end

    it 'deducts MIN_FARE on touch_out' do
      subject.topup(1)
      subject.touch_in
      subject.touch_out
      expect(subject.balance).to eq 0
    end
  end
end
