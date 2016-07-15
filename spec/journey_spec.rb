require 'journey'

describe Journey do
  let(:entry_station) {double(:station, zone: 1)}
  let(:exit_station) {double(:station, zone: 1)}

  describe '#start' do
    it 'assigns an entry staton' do
      subject.start(entry_station)
      expect(subject.entry_station).to be entry_station
    end
  end

  describe '#finish' do
    it 'assigns an exit staton' do
      subject.finish(exit_station)
      expect(subject.exit_station).to be exit_station
    end
  end

  describe '#in_progress' do
    it 'starts out false' do
      expect(subject).not_to be_in_progress
    end
    it 'returns true after a journey has started' do
      subject.start(entry_station)
      expect(subject).to be_in_progress
    end
  end


  describe '#fare' do
    it 'return minimum fare when a journey has been completed' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.fare).to be 1
    end
    context 'when no entry/exit station is present' do
      it 'returns penalty fare if there is no exit station' do
        subject.start(entry_station)
        expect(subject.fare).to be 6
      end
      it 'returns penalty fare if there is no exit station' do
        subject.finish(exit_station)
        expect(subject.fare).to be 6
      end
    end
  end

  context 'given an exit station' do
    let(:station) { double :station }
    let(:other_station) { double :other_station }

  before do
    subject.start(station)
    subject.finish(other_station)
  end

  it 'calculates a fare for zone 1 to zone 1' do
    update_zones(1,1)
    expect(subject.fare).to eq 1
  end

  it 'calculates a fare for zone 1 to zone 2' do
    update_zones(1,2)
    expect(subject.fare).to eq 2
  end

  it 'calculates a fare for zone 6 to zone 5' do
    update_zones(6,5)
    expect(subject.fare).to eq 2
  end

  it 'calculates a fare for zone 6 to zone 1' do
    update_zones(6,2)
    expect(subject.fare).to eq 5
  end

  it "knows if a journey is complete" do
    expect(subject).to be_complete
  end

  def update_zones(entry_zone, exit_zone)
    allow(station).to receive(:zone).and_return(entry_zone)
    allow(other_station).to receive(:zone).and_return(exit_zone)
  end
end

end
