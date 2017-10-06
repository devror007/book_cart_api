require 'spec_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do
    describe 'active' do
      before do
        @active_cart = FactoryGirl.create(:cart)
        @inactive_cart = FactoryGirl.create(:cart, updated_at: Time.now-2.days)
      end

      it 'should return only active carts' do
        expect(Cart.active).to eq([@active_cart])
      end

      it 'should not return expired carts' do
        expect(Cart.active).not_to include([@inactive_cart])
      end
    end
  end

  describe 'class methods' do
    describe 'summary_data' do
      before do
        cart = FactoryGirl.create(:cart)
        @product_1 = FactoryGirl.create(:product)
        @product_2 = FactoryGirl.create(:product)
        cart_item_1 = FactoryGirl.create(:cart_item, cart: cart, product: @product_1, price: @product_1.price, quantity: 2)
        cart_item_2 = FactoryGirl.create(:cart_item, cart: cart, product: @product_2, price: @product_2.price, quantity: 1)
      end
      it 'should return active carts product count and total amount' do
        data = Cart.summary_data
        expect(data.length).to eq(2)
        expect(data[0].total).to eq(@product_1.price * 2)
        expect(data[1].total).to eq(@product_2.price * 1)
        expect(data[0].quantity).to eq(2)
        expect(data[1].quantity).to eq(1)
      end
    end
  end

  describe 'instance methods' do
    describe 'is_expired?' do
      before do
        @active_cart = FactoryGirl.create(:cart)
        @inactive_cart = FactoryGirl.create(:cart, updated_at: Time.now-2.days)
      end

      it 'should return false for active cart' do
        expect(@active_cart.is_expired?).to eq(false)
      end

      it 'should return true for expired cart' do
        expect(@inactive_cart.is_expired?).to eq(true)
      end
    end
  end

end