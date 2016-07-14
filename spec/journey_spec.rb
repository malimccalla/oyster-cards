require 'journey'

describe Journey do
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}

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

end
