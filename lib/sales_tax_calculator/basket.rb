module SalesTaxCalculator
  class Basket
    attr_reader :items

    def initialize
      @items = []
    end

    def add_items(*items)
      @items += items
    end

    def total
      items.map(&:price).inject(&:+)
    end

    def total_with_sales_tax
      (total + total_sales_tax).round(2)
    end

    def items_with_tax
      items.map(&:with_sales_tax)
    end

    def total_sales_tax
      items.map(&:sales_tax_amount).inject(&:+)
    end
  end
end
