class Discount
  attr_reader :code
  attr_reader :product

  def initialize(code, product, min_quantity)
    @code = code
    @product = product
    @min_quantity = min_quantity
  end

  def valid_discount(quantity)
    if quantity >= @min_quantity
      return true
    end
    return false
  end
end

class TwoForOne < Discount
  def initialize(code, product, min_quantity)
    super
  end

  public
  def apply_discount(quantity, price)
    return (quantity / 2.0).ceil * price
  end

end

class Bulk < Discount
  def initialize(code, product, min_quantity, new_price)
    @new_price = new_price
    super(code, product, min_quantity)
  end

  public
  def apply_discount(quantity, price)
    return quantity * @new_price
  end

end
