require 'rails_helper'


describe DiscountTenWhiteColor do
  let!(:order) { FactoryBot.create(:order) }

  let(:food_category) { FactoryBot.create(:category, name: 'Food') }
  let(:food_product) { FactoryBot.create(:product, name: 'Food1', price: 220.43, category: food_category, color: 'white') }
  let!(:order_item_1) { FactoryBot.create(:order_item, product: food_product, order: order, unit_price: 220.43, quantity: 7) }



  let(:mouse_category) { FactoryBot.create(:category, name: 'Mouse') }
  let(:keyboard_category) { FactoryBot.create(:category, name: 'Keyboard') }

  let(:mouse_product) { FactoryBot.create(:product, name: 'Mouse 1', price: 1500.44, category: mouse_category, color: 'white') }
  let(:mouse_product_2) { FactoryBot.create(:product, name: 'Mouse 2', price: 1300.44, category: mouse_category) }

  let(:keyboard_product) { FactoryBot.create(:product, name: 'Keyboard 1', price: 800, category: keyboard_category) }




  let!(:mouse_order_1) { FactoryBot.create(:order_item, product: mouse_product, order: order, unit_price: 1500.44, quantity: 3) }
  let!(:mouse_order_2) { FactoryBot.create(:order_item, product: mouse_product_2, order: order, unit_price: 1300.44, quantity: 8) }
  let!(:keyboard_order_1) { FactoryBot.create(:order_item, product: keyboard_product, order: order, unit_price: 800, quantity: 12) }

  let(:hash) do
    {
        items: order.order_items,
        discounts: []
    }
  end

  subject(:context) { described_class.call(hash) }

  describe ".call" do
    it "returns same items" do
      expect(context[:items]).to eq order.order_items
    end

    it "adds discounts" do
      expect(context[:discounts]).to eq [{amount: 60.44, name: "White Stuff"}]
    end
  end
end
