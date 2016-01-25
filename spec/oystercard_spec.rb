require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#initialize' do

    it 'initializes with a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end

  end

end
