class Product < ActiveRecord::Base
  has_many :product_orders
  has_many :customers, through: :product_orders
  validates :amount_in_stock, numericality: { greater_than_or_equal_to: 0 }

  def self.in_stock
    self.where('amount_in_stock > 0')
  end

  def self.out_of_stock
    self.where(amount_in_stock: 0)
  end

  def decrement_amount_in_stock!
    raise InvalidDecrementOfStock unless self.amount_in_stock > 0
    self.amount_in_stock -= 1
    save!
  end

  def increment_amount_in_stock!
    self.amount_in_stock += 1
    save!
  end

  class InvalidDecrementOfStock < StandardError
  end
end
