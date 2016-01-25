require 'oystercard'

describe Oystercard do
  it 'should return 0 when checking new card balance' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    subject(:oystercard){described_class.new(1)}

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should adjust value of balance by top_up argument' do
      expect {oystercard.top_up(1)}.to change {oystercard.balance}.by(1)
    end

    it 'should reject top-up if it exceeds maximum value' do
      expect {oystercard.top_up(100)}.to raise_error ("Can't top up past £100")
    end
  end

  describe '#deduct_credit' do

    subject(:oystercard){described_class.new(10)}

    it { is_expected.to respond_to(:deduct_credit).with(1).argument}
    it 'should deduct fee argument from @balance' do
      expect {oystercard.deduct_credit(5)}.to change {oystercard.balance}.by(-5)
    end
  end
end
