require 'oystercard'

describe Oystercard do
  subject { described_class.new }
  let(:minimum_fare) { Oystercard::MINIMUM_FARE }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:entry_station) { double(:entry_station, zone: 1) }
  let(:exit_station) { double(:exit_station, zone: 1) }
  let(:full_card) { described_class.new}
  before(:example) { full_card.top_up(maximum_balance) }
  let(:journey) {double(:journey)}


  describe "#balance" do
    it "is expected to return a float" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it "is expected to top up the oystercard by a specified amount" do
      expect{subject.top_up(minimum_fare)}.to change{ subject.balance }.by(minimum_fare)
    end
    context 'when card is fully topped up' do
      it "will raise an error if card limit reached" do
        expect {full_card.top_up(minimum_fare)}.to raise_error "Unable to top up: £#{maximum_balance} limit exceeded"
      end
    end
  end

  describe '#touch_out' do

    context 'when card is fully topped up' do
      it 'reduces the balance by minimum fare' do
        full_card.touch_in(entry_station)
        expect{full_card.touch_out(exit_station)}.to change{full_card.balance}.by(-minimum_fare)
      end

    end
  end

  describe '#touch_in' do
    it 'raises an error when balance is below minimum fare' do
      expect{subject.touch_in(entry_station)}.to raise_error "Please top up your oystercard"
    end
  end
end
