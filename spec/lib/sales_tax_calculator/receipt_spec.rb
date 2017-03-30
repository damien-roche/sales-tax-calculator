require 'spec_helper'

module SalesTaxCalculator
  describe Receipt do
    let(:receipt) { Receipt.new(items, total_price, total_sales_tax) }

    let(:items) { [item_1, item_2] }

    let(:item_1) {
      double(LineItem, quantity: 1, product: 'chocolate', price: 10.00)
    }

    let(:item_2) {
      double(LineItem, quantity: 1, product: 'more chocolate', price: 10.00)
    }

    let(:total_price) { 20.00 }
    let(:total_sales_tax) { 0.00 }

    describe '#print' do
      let(:line_1) { items.join("\n") }

      let(:receipt_text) {
        <<~RECEIPT
          1, chocolate, 10.00
          1, more chocolate, 10.00

          Sales Taxes: 0.00
          Total: 20.00
        RECEIPT
      }

      it 'outputs receipt to STDOUT' do
        expect(STDOUT).to receive(:puts).with(receipt_text)

        receipt.print
      end
    end
  end
end
