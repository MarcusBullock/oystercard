require 'oystercard'

describe Oystercard do

  it 'should return 0 when checking new card balance' do
    expect(subject.balance).to eq 0
  end

end
