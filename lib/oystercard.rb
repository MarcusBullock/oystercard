class Oystercard
  attr_reader :balance, :in_journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @max_balance = MAX_BALANCE
  end

  def top_up amount
    fail "Max balance is £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" if balance < MIN_FARE
    # TODO: store station in instance var
    @in_journey = true
  end

  def touch_out(station)
    deduct(MIN_FARE)
    # TODO: store station in instance var
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  
  def deduct amount
    @balance -= amount
  end

end
