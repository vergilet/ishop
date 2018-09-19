require 'rails_helper'


describe DiscountFoodAfterSix do
  let(:food_category) { FactoryBot.create(:category, name: 'Food') }
  let(:not_food_category) { FactoryBot.create(:category, name: 'Not Food') }

  let(:food_product) { FactoryBot.create(:product, name: 'Food1', price: 220.43, category: food_category) }
  let(:food_product_2) { FactoryBot.create(:product, name: 'Food2', price: 56.30, category: food_category) }
  let(:not_food_product) { FactoryBot.create(:product, name: 'Car1', price: 1000.00, category: not_food_category) }

  let!(:order) { FactoryBot.create(:order) }
  let!(:order_item_1) { FactoryBot.create(:order_item, product: food_product, order: order, unit_price: 220.43, quantity: 1) }
  let!(:order_item_2) { FactoryBot.create(:order_item, product: not_food_product, order: order, unit_price: 1000.0, quantity: 1) }
  let!(:order_item_3) { FactoryBot.create(:order_item, product: food_product_2, order: order, unit_price: 56.30, quantity: 3) }

  let(:hash) do
    {
      items: order.order_items,
      discounts: []
    }
  end

  subject(:context) { described_class.call(hash) }

  describe ".call" do
    context 'after six' do
      before do
        Timecop.freeze(Time.local(2008, 9, 1, 18, 0, 0))
      end

      it "returns same items" do
        expect(context[:items]).to eq order.order_items
      end

      it "adds discounts" do
        expect(context[:discounts]).to eq [{amount: 369.86, name: "Food after 18:00"}]
      end
    end

    context 'before six' do
      before do
        Timecop.freeze(Time.local(2008, 9, 1, 17, 0, 0))
      end

      it "returns same items" do
        expect(context[:items]).to eq order.order_items
      end

      it "adds discounts" do
        expect(context[:discounts]).to eq []
      end
    end
  end
end
