require 'pry'

class CashRegister
  attr_accessor :total, :discount, :items, :previous_transaction

  class Transaction
    attr_accessor :item_name, :price, :quantity

    def initialize(item_name, price, quantity)
      @item_name = item_name
      @price = price
      @quantity = quantity
    end

  end #end of Transaction subclass

  def initialize(discount = 0)
    @total = 0
    @discount = discount
    @items = []
    @transactions = []
  end #end of CashRegister initialize method

  def add_item(item_name, price, quantity = 1)
    @transactions << Transaction.new(item_name, price, quantity)
    quantity.times{self.items << item_name}
    self.total += price*quantity
  end #end of add_item method

  def apply_discount
    #binding.pry
    self.total *= (1-(self.discount/100.0))
    discount_s = "After the discount, the total comes to $#{self.total.to_i}."
    no_discount_s = "There is no discount to apply."
    discount > 0 ? discount_s : no_discount_s
  end #end of apply_discount method

  def void_last_transaction
    transaction = @transactions.pop
    self.total -= (transaction.price * transaction.quantity)
    transaction.quantity.times{self.items.delete(transaction.item_name)}
  end #end of void_last_transaction method


end #end of CashRegister class
