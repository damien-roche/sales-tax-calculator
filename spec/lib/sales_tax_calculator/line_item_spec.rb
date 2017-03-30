require 'spec_helper'

module SalesTaxCalculator
  describe LineItem do
    let(:line_item) { LineItem.new(quantity, product, price) }

    let(:quantity) { 1 }
    let(:product) { 'chocolate' }
    let(:price) { 10.00 }

    before do
      allow(LineItem).to receive(:new).
        with(quantity, product, price).
        and_return(line_item)
    end

    describe '#with_sales_tax' do
      let(:line_item_with_sales_tax) {
        double(
          LineItem,
          quantity: quantity,
          product: product,
          price: price_with_sales_tax
        )
      }

      let(:price_with_sales_tax) { 10.5 }

      before do
        allow(LineItem).to receive(:new).
          with(quantity, product, price_with_sales_tax).
          and_return(line_item_with_sales_tax)

        allow(line_item).to receive(:price_with_sales_tax).
          and_return(price_with_sales_tax)
      end

      it 'returns a new LineItem with sales tax applied to price' do
        expect(line_item.with_sales_tax).to eql(line_item_with_sales_tax)
      end
    end

    describe '#sales_tax_amount' do
      let(:calculator) { double(Calculator, sales_tax_amount: 10.5) }

      before do
        allow(Calculator).to receive(:new).
          with(quantity, product, price).
          and_return(calculator)
      end

      it 'uses Calculator to determine sales tax amount' do
        expect(line_item.sales_tax_amount).to eql(10.5)
      end
    end
  end
end
