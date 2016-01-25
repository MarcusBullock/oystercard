class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def topup(value)
    fail "Exceeded max limit: #{MAX_LIMIT}" if @balance + value >= MAX_LIMIT
    @balance += value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'low balance' if balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  private

  def deduct(value)
    @balance -= value
  end

end
