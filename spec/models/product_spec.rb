require 'spec_helper'

describe Product do
  describe 'adding to order' do
    let(:order)   { create(:order) }

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

  describe 'decrementing the amount in stock' do
    it 'decreases the amount in stock by 1' do
      product = build(:product, amount_in_stock: 5)
      product.decrement_amount_in_stock!
      expect(product.amount_in_stock).to eq 4
    end

    it 'raises an exception if theres no remaining product' do
      product = build(:product, amount_in_stock: 1)
      product.decrement_amount_in_stock!
      expect { product.decrement_amount_in_stock! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
