require 'spec_helper'

describe Product do
  let(:order) { create(:order) }

  describe 'in stock products' do
    it 'retrieves all products with stock greater than 0' do
                 create(:product, amount_in_stock: 0)
      product2 = create(:product, amount_in_stock: 1)
      product3 = create(:product, amount_in_stock: 5)

      expect(Product.in_stock).to match_array([product2, product3])
    end
  end

  describe 'out of stock products' do
    it 'retrieves all products with a stock of 0' do
      product1 = create(:product, amount_in_stock: 0)
      create(:product, amount_in_stock: 1)
      product3 = create(:product, amount_in_stock: 0)

      expect(Product.out_of_stock).to match_array([product1, product3])
    end
  end

  describe 'adding to order' do
    context 'with remaining stock' do
      let(:product) { create(:product, amount_in_stock: 5) }

      it 'adds the product to the order' do
        product.orders << order
      end
    end

    context 'with no remaining stock' do
      let(:product) { create(:product, amount_in_stock: 0) }

      before do
        expect { product.orders << order }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'doesnt add the product to the order' do
        expect(product.orders).to_not include(order)
      end

      it 'doesnt decrement the amount in stock' do
        product.reload
        expect(product.amount_in_stock).to eq(0)
      end
    end
  end

  describe 'removing from order' do
    let(:product) { create(:product, amount_in_stock: 1) }

    before do
      product.orders << order
    end

    it 'increases the amount in stock' do
      expect {
        product.orders.destroy(order)
      }.to change { product.amount_in_stock }.by(1)
    end

    it 'removes the product from the order' do
      product.orders.destroy(order)
      expect(product.orders).to_not include(order)
    end
  end

  describe 'decrementing the amount in stock' do
    it 'decreases the amount in stock by 1' do
      product = build(:product, amount_in_stock: 5)
      expect {
        product.decrement_amount_in_stock!
      }.to change { product.amount_in_stock }.by(-1)
    end

    it 'raises an exception if theres no remaining product' do
      product = build(:product, amount_in_stock: 1)
      product.decrement_amount_in_stock!
      expect { product.decrement_amount_in_stock! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'incrementing the amount in stock' do
    let(:product) { create(:product, amount_in_stock: 1) }

    it 'increases the amount in stock by 1' do
      expect {
        product.increment_amount_in_stock!
      }.to change { product.amount_in_stock }.by(1)
    end
  end
end
