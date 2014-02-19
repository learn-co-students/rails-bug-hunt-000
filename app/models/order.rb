class Order < ActiveRecord::Base
  has_many :product_orders
  has_many :products, through: :product_orders

  def total_cost_in_cents
    products.sum(:cost_in_cents)
  end
end
