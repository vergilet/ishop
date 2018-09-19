class FoodAfterSix
  START_TIME = 18
  END_TIME = 23
  DISCOUNT = 5 # percentage

  include Interactor

  def call
    # {items: [], discounts: []}
    return unless Time.now.hour.between?(START_TIME, END_TIME)
    appropriate_items_price = 0
    context[:items].each do |item|
      if item.category.name == 'Food'
        appropriate_items_price += item.price
      end
    end
    context[:discount] << discount(appropriate_items_price)
  end

  def discount(price)
    { name: 'Food after 18:00', amount: price * (100 - 5) / 100 }
  end
end