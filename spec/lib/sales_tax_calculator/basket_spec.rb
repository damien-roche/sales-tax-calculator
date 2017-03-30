require 'spec_helper'

module SalesTaxCalculator
  describe Basket do
    let(:basket) { Basket.new }

    let(:items) {
      [
        line_item_1,
        line_item_2
      ]
    }

    let(:line_item_1) {
      double(
        LineItem,
        price: 10,
        sales_tax_amount: 0.5,
        with_sales_tax: double(LineItem, price: 10.5)
      )
    }

    let(:line_item_2) {
      double(
        LineItem,
        price: 15,
        sales_tax_amount: 0,
        with_sales_tax: double(LineItem, price: 0)
      )
    }

    before { basket.add_items(*items) }

    describe '#add_items' do
      it 'adds items to the basket' do
        basket.add_items(*items)

        expect(basket.items.size).to eq(4)
      end
    end

    describe '#total' do
      it 'returns total price of items in basket' do
        expect(basket.total).to eq(25)
      end
    end

    describe '#total_with_sales_tax' do
      it 'returns total price of items in basket with sales tax' do
        expect(basket.total_with_sales_tax).to eq(25.5)
      end
    end

    describe '#items_with_tax' do
      let(:expected_items) { items.map(&:with_sales_tax) }

      it 'returns a new array of items with tax applied' do
        expect(basket.items_with_tax).to eql(expected_items)
      end
    end

    describe '#total_sales_tax' do
      it 'returns total sales tax amount of all items' do
        expect(basket.total_sales_tax).to eql(0.5)
      end
    end
  end
end
