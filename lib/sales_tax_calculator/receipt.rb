# This class is used to encapsulate display logic. Usually, I would prefer
# to have something that decorates models/other objects for formatting purposes

module SalesTaxCalculator
  class Receipt
    attr_reader :items, :total_price, :total_sales_tax
    private :items, :total_price, :total_sales_tax

    # Here, again, I have decided to pass in values rather than
    # the basket object (which had access to these values) as it helps
    # decouple them.
    def initialize(items, total_price, total_sales_tax)
      @items = items
      @total_price = '%.2f' % total_price
      @total_sales_tax = '%.2f' % total_sales_tax
    end

    # not that impressed with this, but it is a simple way to output receipt
    # in desired format. Of course, a CSV would be better suited (or a database)
    def print
      puts <<~RECEIPT
        #{parsed_items.join("\n")}

        Sales Taxes: #{total_sales_tax}
        Total: #{total_price}
      RECEIPT
    end

    private

    def parsed_items
      items.map do |item|
        # Sadly, there is still some coupling ;)
        item_price = '%.2f' % item.price
        [item.quantity, item.product, item_price].join(', ')
      end
    end
  end
end
