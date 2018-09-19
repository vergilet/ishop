require 'rails_helper'


describe DiscountFoodAfterSix do
  let(:food_category) { FactoryBot.create(:category, name: 'Food') }
  let(:not_food_category) { FactoryBot.create(:category, name: 'Not Food') }
  let(:food_product) { FactoryBot.create(:product, name: 'Food1', price: 220.43, category: food_category) }
  let(:not_food_product) { FactoryBot.create(:product, name: 'Car1', price: 1000.00, category: not_food_category) }

  let(:order) { FactoryBot.create(:order) }
  let(:order_item_1) { FactoryBot.create(:order_item, product: food_category, order: order) }
  let(:order_item_2) { FactoryBot.create(:order_item, product: not_food_product, order: order) }

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
        Timecop.freeze(2008, 9, 1, 18, 0, 0)
      end

      it "provides the user" do
        expect(context[:items]).to eq([1])
      end
    end
  end
end
