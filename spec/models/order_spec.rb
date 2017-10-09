require 'spec_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should have_many(:order_items).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe 'instance methods' do
    describe 'total_price' do
      before do
        user = FactoryGirl.create(:user)
        cart = FactoryGirl.create(:cart, user: user)
        @order = FactoryGirl.create(:order, user: user)
        @order_item_1 = FactoryGirl.create(:order_item, order: @order, quantity: 2, price: 400)
        @order_item_2 = FactoryGirl.create(:order_item, order: @order, quantity: 4, price: 200)
      end
      it 'should return total price for order' do
        total = @order_item_1.price * @order_item_1.quantity +  @order_item_2.price * @order_item_2.quantity
        expect(@order.total_price).to eq(total)
      end
    end

    describe 'confirm_order' do
      before do
        @product = FactoryGirl.create(:product)
        @user = FactoryGirl.create(:user)
        @cart = FactoryGirl.create(:cart, user: @user)
        @cart_item = FactoryGirl.create(:cart_item, cart: @cart, product: @product)
      end

      it 'should build the order items' do
        order = @user.orders.build
        expect(order.order_items).to eq([])
        result = order.confirm!
        expect(order.order_items).not_to eq([])
        expect(order.order_items[0].quantity).to eq(@cart_item.quantity)
        expect(order.order_items[0].product_id).to eq(@product.id)
      end
    end
  end
end