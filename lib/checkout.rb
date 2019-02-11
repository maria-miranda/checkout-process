class Checkout
  def initialize(pricing_rules)
    @items = Hash.new(0)
    @price = 0

    @products = pricing_rules['products']
    @discounts = pricing_rules['discounts']
  end

  public
  def scan(item_code)
    unless @products.has_key?(item_code)
      puts "Error: Product #{item_code} not available!"
      return
    end

    @items[item_code] += 1
  end

  def total
    @items.each do |item, quantity|
      if @discounts.has_key?(item) and @discounts[item].valid_discount(quantity)
          @price += @discounts[item].apply_discount(quantity, @products[item].price)
      else
        @price += quantity * @products[item].price
      end
    end
    return "%.2f€" % @price
  end

end
