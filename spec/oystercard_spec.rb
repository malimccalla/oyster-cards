require 'oystercard'

describe Oystercard do
  subject { described_class.new }
  let(:minimum_fare) { Oystercard::MINIMUM_FARE }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:full_card) { described_class.new}
  let(:journey) {{entry_station => exit_station}}
  before(:example) { full_card.top_up(maximum_balance) }

  describe 'initialize' do

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe "balance" do
    it "is expected to return a float" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "top_up" do
    it "is expected to top up the oystercard by a specified amount" do
      expect{subject.top_up(minimum_fare)}.to change{ subject.balance }.by(minimum_fare)
    end
    context 'when card is fully topped up' do
      it "will raise an error if card limit reached" do
        expect {full_card.top_up(minimum_fare)}.to raise_error "Unable to top up: £#{maximum_balance} limit exceeded"
      end
    end
  end

  describe 'in_journey?' do
    context 'when card is fully topped up' do
      it 'reports whether card is in journey' do
        full_card.touch_in(entry_station)
        expect(full_card).to be_in_journey
      end
    end
  end

  describe 'touch_out' do
    it 'forgets entry station' do
      full_card.touch_in(entry_station)
      expect{full_card.touch_out(exit_station)}.to change{full_card.entry_station}.to be(nil)
    end
    context 'when card is fully topped up' do
      it 'can change the status of in journey' do
        full_card.touch_in(entry_station)
        expect{full_card.touch_out(exit_station)}.to change{full_card.in_journey?}.to be(false)
      end
      it 'reduces the balance by minimum fare' do
        full_card.touch_in(entry_station)
        expect{full_card.touch_out(exit_station)}.to change{full_card.balance}.by(-minimum_fare)
      end

    end
  end

  describe 'touch_in' do
    it 'can change the status of in journey' do
      expect{full_card.touch_in(entry_station)}.to change{full_card.in_journey?}.to be(true)
    end
    it 'allows the card to remember the entry station' do
      full_card.touch_in(entry_station)
      expect(full_card.entry_station).to eq(entry_station)
    end
    it 'raises an error when balance is below minimum fare' do
      expect{subject.touch_in(entry_station)}.to raise_error "Please top up your oystercard"
    end

    it { is_expected.to respond_to(:touch_in).with(1).argument }

  end

  describe 'journey_history' do
    it 'should default as empty' do
      expect(subject.history).to be_empty
    end
    it 'stores previous entry station history' do
      full_card.touch_in(entry_station)
      full_card.touch_out(exit_station)
      expect(full_card.history).to eq(journey)
    end
    it 'can store multiple journeys' do
      full_card.touch_in(entry_station)
      full_card.touch_out(exit_station)
      full_card.touch_in("archway")
      full_card.touch_out("brixton")
      expect(full_card.history).to eq({entry_station => exit_station, "archway" => "brixton"})
    end
  end

end
