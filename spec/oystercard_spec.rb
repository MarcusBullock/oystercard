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
end
