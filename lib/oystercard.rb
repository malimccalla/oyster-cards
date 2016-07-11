class Oystercard
  MAXIMUM_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail maxium_limit_error if (amount + balance) > MAXIMUM_LIMIT
    @balance += amount
  end

  private

  def maxium_limit_error
    "Unable to top up, £#{MAXIMUM_LIMIT} is the maximum card limit"
  end

end
