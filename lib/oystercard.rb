class Oystercard
  attr_reader :balance

MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up amount
    fail "Max balance is £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct amount
    @balance -= amount
  end

  def touch_in(station)
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

end
