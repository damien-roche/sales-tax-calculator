require './lib/sales_tax_calculator.rb'

# below I have instantiated a new basket and added line items to it
# I then pass values derived from basket into a Receipt object which handles the printing

# Though I could have, I have not added sales tax logic to the Receipt as I believe
# it should only be responsible for display logic, and sales tax is very much
# basket and line item logic

# I have namespaced under SalesTaxCalculator simply because of the way I've
# structured my code in the /lib directory.

basket = SalesTaxCalculator::Basket.new

basket.add_items(
  SalesTaxCalculator::LineItem.new(1, 'music cd', 14.99),
  SalesTaxCalculator::LineItem.new(1, 'book', 12.49),
  SalesTaxCalculator::LineItem.new(1, 'packet of headache pills', 9.75),
  SalesTaxCalculator::LineItem.new(1, 'chocolate', 10.00),
  SalesTaxCalculator::LineItem.new(1, 'imported box of chocolates', 10.00),
  SalesTaxCalculator::LineItem.new(1, 'imported bottle of perfume', 47.50)
)

receipt = SalesTaxCalculator::Receipt.new(
  basket.items_with_tax,
  basket.total_sales_tax,
  basket.total_with_sales_tax
)

receipt.print
