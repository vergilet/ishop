class Order < ApplicationRecord
  has_many :order_items

  def subtotal
    order_items.collect do |order_item|
      order_item.quantity * order_item.unit_price
    end.sum
  end
end
