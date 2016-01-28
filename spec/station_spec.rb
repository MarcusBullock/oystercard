require 'station'

describe Station do
  subject(:station) {described_class.new("Moorgate", 1)}

  it 'has the correct name' do
    expect(station.name).to eq("Moorgate")
  end

  it 'has the correct zone' do
    expect(station.zone).to eq(1)
  end
  
  

end
