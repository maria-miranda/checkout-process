class Product
  attr_reader :code
  attr_reader :price
  attr_reader :name

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
