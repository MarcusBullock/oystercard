require_relative 'barrier'

class Oystercard

  DEFAULT_BALANCE = 0
  DEFAULT_MAX = 100

  attr_reader :balance
  attr_reader :checked_in

  def initialize(balance = DEFAULT_BALANCE)
    @checked_in = false
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

  def check_in
    @checked_in = true
  end

  def check_out
    @checked_in = false
  end

  def travelling?
    @checked_in
  end

end
