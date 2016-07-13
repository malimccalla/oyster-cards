class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Unable to top up: £#{MAXIMUM_BALANCE} limit exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Please top up your oystercard" if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @journeys << {entry_station: entry_station}
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    store_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def store_journey
    @journeys.last.store(:exit_station, exit_station)
    @entry_station = nil
    @exit_station = nil
  end

end
