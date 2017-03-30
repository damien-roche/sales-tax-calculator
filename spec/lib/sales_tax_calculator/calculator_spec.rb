require 'spec_helper'

module SalesTaxCalculator
  describe Calculator do
    let(:calculator) { Calculator.new(quantity, product, price) }

    let(:quantity) { 1 }
    let(:product) { 'wireless mouse' }
    let(:price) { 10.00 }

    describe 'sales_tax_amount' do
      let(:sales_tax_amount) { calculator.sales_tax_amount }

      it 'applies 10% basic sales tax' do
        expect(sales_tax_amount).to eql(1.0)
      end

      context 'when product is food' do
        let(:product) { 'chocolate' }

        it 'does not apply any sales tax' do
          expect(sales_tax_amount).to eql(0.0)
        end
      end

      context 'when product is book' do
        let(:product) { 'the greatest book ever written' }

        it 'does not apply any sales tax' do
          expect(sales_tax_amount).to eql(0.0)
        end
      end

      context 'when product is medical product' do
        let(:product) { 'handful of red pills' }

        it 'does not apply any sales tax' do
          expect(sales_tax_amount).to eql(0.0)
        end
      end

      context 'when product is imported' do
        let(:product) { 'imported chocolate' }

        it 'applies 5% import tax' do
          expect(sales_tax_amount).to eql(0.5)
        end
      end

      context 'when product is imported and not exempt from basic sales tax' do
        let(:product) { 'imported trainers' }

        it 'applies both basic sales tax and import tax' do
          expect(sales_tax_amount).to eql(1.5)
        end
      end

      context 'when sales tax is rounded' do
        let(:product) { 'imported bottle of perfume' }
        let(:price) { 47.50 }

        it 'rounds up to the nearest 0.05' do
          expect(sales_tax_amount).to eql(7.15)
        end
      end
    end
  end
end
