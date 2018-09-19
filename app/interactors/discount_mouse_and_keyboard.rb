class DiscountMouseAndKeyboard
  DISCOUNT = 3 # percentage

  include Interactor

  def call
    mouses = []
    keyboards = []
    context[:items].each do |order_item|
      product = order_item.product
      category = product.category
      if category.name == 'Mouse'
        order_item.quantity.times{ |_| mouses << order_item }
      elsif category.name == 'Keyboard'
        order_item.quantity.times{ |_| keyboards << order_item }
      end
    end
    pairs_amount = [mouses.size, keyboards.size].min
    discounted_mouses = mouses[0...pairs_amount]
    discounted_keyboards = keyboards[0...pairs_amount]
    context[:discounts] << discount(discounted_mouses, discounted_keyboards) unless pairs_amount.zero?
  end

  def discount(mouses, keyboards)
    mouses_price = mouses.sum(&:unit_price)
    keyboards_price = keyboards.sum(&:unit_price)
    price = mouses_price + keyboards_price
    { name: 'Mouse & Keyboard', amount: (price / 100 * DISCOUNT).round(2) }
  end

end