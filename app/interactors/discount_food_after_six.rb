class DiscountFoodAfterSix
  START_TIME = 18
  END_TIME = 23
  DISCOUNT = 5 # percentage

  include Interactor

  def call
    return unless Time.now.hour.between?(START_TIME, END_TIME)
    items_price = 0
    context[:items].each do |order_item|
      items_price += price(order_item)
    end
    context[:discounts] << discount(items_price) unless items_price.zero?
  end

  def discount(price)
    { name: 'Food after 18:00', amount: (price / 100.00 * DISCOUNT).round(2) }
  end

  def price(order_item)
    product = order_item.product
    category = product.category
    category.name == 'Food' ? order_item.unit_price * order_item.quantity : 0
  end
end