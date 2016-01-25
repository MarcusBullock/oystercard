require 'station'

describe Station do
  subject{described_class.new(:aldgate_east, 1)}

  it 'is able to return a station name' do
    expect(subject.name).to eq :aldgate_east
  end

  it 'is able to return a zone number' do
    expect(subject.zone).to eq 1
  end
end
