class CreateProductOrders < ActiveRecord::Migration
  def change
    create_table :product_orders do |t|
      t.integer :product_id
      t.integer :order_id

      t.timestamps
    end
    add_index :product_orders, :product_id
    add_index :product_orders, :order_id
  end
end
