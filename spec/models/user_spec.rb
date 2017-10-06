require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:cart_items) }
    it { should have_one(:cart).dependent(:destroy) }
  end

  describe 'instance methods' do
    describe 'cart_items_count' do
      before do
        @user = FactoryGirl.create(:user)
        cart = FactoryGirl.create(:cart, user: @user)
        @cart_item = FactoryGirl.create(:cart_item, cart: cart, quantity: 4)
        @cart_item_2 = FactoryGirl.create(:cart_item, cart: cart, quantity: 6)
      end

      it 'should return total product quantities added in cart' do
        expect(@user.cart_items_count).to eq(@cart_item.quantity + @cart_item_2.quantity)
      end
    end
  end
end