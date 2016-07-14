require 'journey_log'

describe JourneyLog do

  let(:journey) {double(:journey)}
  let(:entry_station) {double(:station)}
  let(:journey_class) {double(:journey_class)}
  subject {described_class.new(journey_class: journey_class)}




    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(entry_station)
      expect(subject.log).to include journey
    end

end
