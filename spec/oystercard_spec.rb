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
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      expect{subject.top_up(maximum_limit+1)}.to raise_error "Unable to top up, £#{maximum_limit} is the maximum card limit"
    end

  end

  describe '#deduct' do

    it {is_expected.to respond_to(:deduct).with(1).argument}

    it 'deducts an amount from the balance' do
      subject.top_up(10)
      expect{subject.deduct(5)}.to change{subject.balance}.by(-5)
    end

  end

  describe '#in_journey?' do

    it 'reports if a card is in journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'reports if a card is not in a journey' do
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

  end

  describe '#touch_in' do

    it {is_expected.to respond_to(:touch_in)}

    it 'allows a card to be touched in' do
      expect(subject.touch_in).to eq(true)
    end

  end

  describe '#touch_out' do
    it 'allows a card to be touched out' do
      expect(subject.touch_out).to eq(false)
    end
  end

end
