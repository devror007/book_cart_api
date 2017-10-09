require 'spec_helper'

RSpec.describe Api::V1::CartItemsController, type: :controller do
  describe 'before actions' do
    it { is_expected.to use_before_action(:expire_cart) }
    it { is_expected.to use_before_action(:set_cart_item) }
  end

  describe "Post 'create'" do
    before do
      @user = FactoryGirl.create(:user, auth_token: 'abcdefgh')
      @product = FactoryGirl.create(:product)
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
    end

    it 'should fail auth when auth token is not present' do
      post :create, { id: @cart.id, product_id: @product.id }
      expect(json).to eq({"message"=>"Auth Token not provided."})
      expect(response.status).to eq(401)
    end

    it 'should not auth when auth token is invalid' do
      set_headers('xyz')
      post :create, { id: @cart.id, product_id: @product.id }
      expect(json).to eq({"message"=>"Unauthorized."})
      expect(response.status).to eq(401)
    end

    it 'render cart on success' do
      set_headers(@user.reload.auth_token)
      post :create, { id: @cart.id, product_id: @product.id }
      expect(response.status).to eq(200)
    end

    it 'render cart item erros if not saved cart item' do
      allow_any_instance_of(CartItem).to receive(:save).and_return(false)
      set_headers(@user.auth_token)
      post :create, { id: @cart.id, product_id: @product.id }
      expect(json['message']).to eq('sorry, could not add to cart')
      expect(response.status).to eq(422)
    end

    it 'render cart item erros if not saved cart item' do
      set_headers(@user.auth_token)
      post :create, { id: @cart.id, product_id: nil }
      expect(json['message']).to eq('Product not found')
      expect(response.status).to eq(404)
    end
  end
end