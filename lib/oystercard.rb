class Oystercard

  DEFAULT_BALANCE = 0
  DEFAULT_MAX = 100

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @max_balance = DEFAULT_MAX
  end

  def top_up(value)
    fail "Can't top up past £100" if (value > (DEFAULT_MAX - @balance))
    @balance += value
  end

  def deduct_credit(fee)
    @balance -= fee
  end
end
