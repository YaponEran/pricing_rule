class Pricing

  def initialize
    @pepci_cola = []
    @coca_cola = []
  end

  def count_by_rule(product)
    if product[:code] == "PC"
      @pepci_cola << product
      if @pepci_cola.count >= 3
        product[:price] = discount_procentage(product[:price], 20)
      end
    end

    if product[:code] == "CC"
      @coca_cola << product
      if @coca_cola.count == 2
        product[:price] = buy_one_get_one_free(product[:price])
      end
      if @coca_cola.count >= 3
        product[:price] = 1
      end
    end
  end

  private
  def discount_procentage(sell_price, discount_procent)
    sell_price - (sell_price / 100 * discount_procent)
  end

  def buy_one_get_one_free(price)
    price / 2
  end

end

class Checkout

  attr_reader :product

  def initialize(rule)
    @rule = rule
    @product = []
  end

  def add(item)
    @rule.count_by_rule(item)
    @product << item
  end

  def total
    total = 0
    @product.each do |elem|
      total += elem[:price] 
    end

    puts total
  end
end

pr = Pricing.new
co = Checkout.new(pr)

CC = { code: "CC", name: "Coca-Cola", price: 1.50 }
PC = { code: "PC", name: "Pepci-Cola", price: 2.00 }
WA = { code: "WA", name: "Water", price: 0.85 }

# co.add(PC)
# co.add(CC)
# co.add(PC)
# co.add(WA)
# co.add(PC)
# co.add(CC) => 7.15

# co.add(CC)
# co.add(PC)
# co.add(WA) => 4.35

# co.add(CC)
# co.add(PC)
# co.add(CC)
# co.add(CC) => 5.00

co.total
