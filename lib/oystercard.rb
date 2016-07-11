class Oystercard
  MAXIMUM_LIMIT = 90
  attr_reader :balance



  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail maxium_limit_error if (amount + balance) > MAXIMUM_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def maxium_limit_error
    "Unable to top up, £#{MAXIMUM_LIMIT} is the maximum card limit"
  end

end
