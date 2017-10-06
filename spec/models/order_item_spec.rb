require 'spec_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'instance methods' do
    describe 'total_price' do
      before do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:cart, user: user)
        order = FactoryGirl.create(:order, user: user)
        @order_item = FactoryGirl.create(:order_item, quantity: 3, price: 30, order: order)
      end
      it 'should return total price for the order item' do
        expect(@order_item.total_price).to eq(90)
      end
    end
  end
end