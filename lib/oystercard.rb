class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
attr_reader :balance
attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Unable to top up: £#{MAXIMUM_BALANCE} limit exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Please top up your oystercard" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
