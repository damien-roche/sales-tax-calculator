module SalesTaxCalculator
  class LineItem
    attr_reader :quantity, :product, :price

    def initialize(quantity, product, price)
      @quantity, @product, @price = quantity, product, price
    end

    # Here I have returned a new LineItem because I think it is dangerous
    # to modify the existing line item price
    def with_sales_tax
      LineItem.new(quantity, product, price_with_sales_tax)
    end

    # I did think about memoizing this but it would have introduced a sneaky bug
    # whereby the above `price_with_sales_tax` being passed into LineItem
    # would have called this method, returning the same value even if the
    # LineItem quantity or base price had changed.
    #
    # Finally, I have passed in quantity, product, and price instead of
    # the entire object because I don't like the idea of Calculator
    # knowing too much about LineItem
    def sales_tax_amount
      Calculator.new(quantity, product, price).sales_tax_amount
    end

    private

    # This is simply private because we are not calling it outside of this class
    # In reality, this would likely be public as is a useful value
    def price_with_sales_tax
      (price + sales_tax_amount).round(2)
    end
  end
end
