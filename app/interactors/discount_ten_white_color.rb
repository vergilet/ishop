class DiscountTenWhiteColor
  DISCOUNT = 1 # percentage
  include Interactor

  def call
    white_products = []
    context[:items].each do |order_item|
      product = order_item.product
      if product.color == 'white'
        order_item.quantity.times{ |_| white_products << order_item }
      end
    end
    context[:discounts] << discount(white_products) unless white_products.empty?
  end

  def discount(products)
    price = products.sum(&:unit_price)
    { name: 'White Stuff', amount: (price / 100 * DISCOUNT).round(2) }
  end
end