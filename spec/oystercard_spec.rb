require 'oystercard'

describe Oystercard do

  describe '#balance' do

    it 'allows for reading of balance' do
      expect(subject.balance).to eq(0)
    end

  end

  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it 'can top up the balance' do
      expect{subject.top_up(1)}.to change{subject.balance}.by(1)
    end

    it 'raises an error if balance exceeds maximum limit' do
      expect{subject.top_up(91)}.to raise_error "Unable to top up, £#{Oystercard::MAXIMUM_LIMIT} is the maximum card limit"
    end

  end

end
