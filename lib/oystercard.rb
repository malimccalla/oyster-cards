require_relative 'journey'

class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1

attr_reader :balance, :log

  def initialize
    @balance = 0
    @journey = Journey.new
    @log = []
  end

  def top_up(amount)
    fail max_balance_error if maxed_out(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail min_balance_error if not_enough_money
    if @journey.in_progress?
      deduct(@journey.fare)
      log_journey
    end
    @journey.start(entry_station)

  end

  def in_journey?
    @journey.in_progress?
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.fare)
    log_journey
  end

  private

  def max_balance_error
    "Unable to top up: £#{MAXIMUM_BALANCE} limit exceeded"
  end

  def maxed_out(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def min_balance_error
    "Please top up your oystercard"
  end

  def not_enough_money
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

  def log_journey
    @log << @journey
    @journey = Journey.new
  end

end
