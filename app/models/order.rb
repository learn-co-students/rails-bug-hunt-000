class Order < ActiveRecord::Base
  has_many :product_orders
  has_many :products, through: :product_orders

  include AASM

  # https://github.com/aasm/aasm
  aasm do
    state :unsubmitted, initial: true
    state :processing
    state :shipped

    event :submit do
      transitions from: :unsubmitted, to: :processing
    end

    event :ship do
      transitions from: :processing, to: :shipped
    end
  end

  def total_cost_in_cents
    products.sum(:cost_in_cents)
  end
end
