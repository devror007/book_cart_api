require 'spec_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe 'instance methods' do
    before do
      @product = FactoryGirl.create(:product)
      @cart_item = FactoryGirl.create(:cart_item, quantity: 3, price: 30, product: @product)
    end
    describe 'total_price' do
      it 'should return total price for cart items' do
        expect(@cart_item.total_price).to eq(@cart_item.quantity * @product.price)
      end
    end

    describe 'price_change?' do
      it 'should return true if price change' do
        expect(@cart_item.price_change?).to eq(true)
      end

      it 'should return false if price unchanged' do
        cart_item = FactoryGirl.create(:cart_item, product: @product, price: @product.price)
        expect(cart_item.price_change?).to eq(false)
      end
    end
  end
end