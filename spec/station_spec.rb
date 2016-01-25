require 'station'

describe Station do
  subject(:station) {Station.new :aldgate_east, 1}

  it 'is able to return a station name' do
    expect(subject.name).to eq :aldgate_east
  end

  it 'is able to return a zone number' do
    expect(subject.zone).to eq 1
  end
end
