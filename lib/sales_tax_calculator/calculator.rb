# Notes:
# I have obviously not created extensive checks for tax exemptions.
# In reality, I would likely have a product type (book, food, medical)
# which I would then check against. Instead, I have just checked the product string

module SalesTaxCalculator
  class Calculator
    # lots of ways we could store these values, I have opted for cosntants
    # because it is clear as you read the class
    # Also, I'm not using integers (10, 5, respectively) and calculating these floats
    # because it makes the calculations below more readable this way
    BASIC_SALES_TAX_PERCENT = 0.10
    IMPORTED_SALES_TAX_PERCENT = 0.05

    attr_reader :quantity, :product, :price
    private :quantity, :product, :price

    def initialize(quantity, product, price)
      @quantity, @product, @price = quantity, product, price
    end

    # this is the first place I'd think about refactoring. I would prefer to
    # do this in a more flexible way whereby I could have a collection of
    # sales tax objects which I can then iterate over and apply to the amount.
    # However, for simplicity, and because I have already demonstrated object
    # orientation, I have kept it.
    def sales_tax_amount
      amount = 0

      amount += basic_sales_tax if !exempt?
      amount += imported_sales_tax if imported?

      # One thing I am unsure about is whether to round here or for each
      # tax applied
      (amount * 20).ceil / 20.0
    end

    private

    def basic_sales_tax
      BASIC_SALES_TAX_PERCENT * total_price
    end

    def total_price
      quantity * price
    end

    def exempt?
      book? || food? || medical_product?
    end

    def book?
      product.include? 'book'
    end

    def food?
      product.include? 'chocolate'
    end

    def medical_product?
      product.include? 'pills'
    end

    def imported_sales_tax
      IMPORTED_SALES_TAX_PERCENT * total_price
    end

    def imported?
      product.include? 'imported'
    end
  end
end
