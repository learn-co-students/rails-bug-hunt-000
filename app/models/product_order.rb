class ProductOrder < ActiveRecord::Base
  belongs_to :product, inverse_of: :product_orders
  belongs_to :order, inverse_of: :product_orders
end
