class Oystercard
  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
    @entry_station = nil
  end

  def top_up amount
    fail "Max balance is £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in entry_station
    fail "Insufficient balance" if balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out exit_station
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct amount
    @balance -= amount
  end

end
