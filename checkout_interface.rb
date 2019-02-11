require_relative 'lib/product'
require_relative 'lib/discount'
require_relative 'lib/checkout'

# List of products
ticket = Product.new("TICKET", "Triggerise Ticket", 5)
hoodie = Product.new("HOODIE", "Triggerise Hoodie", 20)
hat = Product.new("HAT", "Triggerise Hat", 7.50)

# Available discounts
two_for_one = TwoForOne.new("2_for_1", "TICKET", 2)
bulk = Bulk.new("bulk", "HOODIE", 3, 19)

pricing_rules = {'products' => {ticket.code => ticket, hoodie.code => hoodie, hat.code => hat},
                'discounts' => {two_for_one.product => two_for_one, bulk.product => bulk}}

co = Checkout.new(pricing_rules)
co.scan("TICKET")
co.scan("HOODIE")
co.scan("HAT")
price = co.total
puts "Total: #{price}"
