require_relative "../lib/checkout"
require_relative "../lib/product"
require_relative "../lib/discount"
require "test/unit"

class TestCheckout < Test::Unit::TestCase
  def setup
    # List of products
    @ticket = Product.new("TICKET", "Triggerise Ticket", 5)
    @hoodie = Product.new("HOODIE", "Triggerise Hoodie", 20)
    @hat = Product.new("HAT", "Triggerise Hat", 7.50)

    # Available discounts
    @two_for_one = TwoForOne.new("2_for_1", "TICKET", 2)
    @bulk = Bulk.new("bulk", "HOODIE", 3, 19)

    @pricing_rules = {'products' => {@ticket.code => @ticket, @hoodie.code => @hoodie, @hat.code => @hat},
                    'discounts' => {@two_for_one.product => @two_for_one, @bulk.product => @bulk}}

    @checkout = Checkout.new(@pricing_rules)
  end

  def test_ticket
    @checkout.scan("TICKET")
    price = @checkout.total
    assert_equal('5.00€', price)
  end

  def test_hoodie
    @checkout.scan("HOODIE")
    price = @checkout.total
    assert_equal('20.00€', price)
  end

  def test_hat
    @checkout.scan("HAT")
    price = @checkout.total
    assert_equal('7.50€', price)
  end

  def test_one_of_each
    @checkout.scan("TICKET")
    @checkout.scan("HOODIE")
    @checkout.scan("HAT")
    price = @checkout.total
    assert_equal("32.50€", price)
  end

  def test_multiple_hats
    @checkout.scan("HAT")
    @checkout.scan("HAT")
    @checkout.scan("HAT")
    price = @checkout.total
    assert_equal("22.50€", price)
  end

  def test_2for1_discount
    @checkout.scan("TICKET")
    @checkout.scan("HOODIE")
    @checkout.scan("TICKET")
    price = @checkout.total
    assert_equal("25.00€", price)
  end

  def test_bulk_discount
    @checkout.scan("HOODIE")
    @checkout.scan("HOODIE")
    @checkout.scan("HOODIE")
    @checkout.scan("TICKET")
    @checkout.scan("HOODIE")
    price = @checkout.total
    assert_equal("81.00€", price)
  end

  def test_all_discounts
    @checkout.scan("TICKET")
    @checkout.scan("HOODIE")
    @checkout.scan("TICKET")
    @checkout.scan("TICKET")
    @checkout.scan("HAT")
    @checkout.scan("HOODIE")
    @checkout.scan("HOODIE")
    price = @checkout.total
    assert_equal("74.50€", price)
  end

  def test_failure
    @checkout.scan("TICKET")
    @checkout.scan("HOODIE")
    @checkout.scan("HAT")
    @checkout.scan("TSHIRT")
    price = @checkout.total
    assert_equal("32.50€", price)
  end


end
