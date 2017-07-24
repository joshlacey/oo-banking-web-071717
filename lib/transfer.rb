require 'pry'
class Transfer

  attr_accessor :status, :sender, :receiver, :amount

@@transfers = []

  def initialize(sender, receiver, amount)
    @receiver = receiver
    @sender = sender
    @amount = amount
    @status = "pending"
  end

  def valid?
    @receiver.valid? && @sender.valid? && @sender.balance >= @amount
  end

  def run
    self.status != "complete"
  end

  def execute_transaction
    if self.valid? && self.run
      @receiver.balance += @amount
      @sender.balance -= @amount
      self.status = "complete"
      @@transfers << self
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @receiver.balance -= @amount
      @sender.balance += @amount
      self.status = "reversed"
    end
  end

end
