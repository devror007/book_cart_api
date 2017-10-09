require 'spec_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  describe 'before actions' do
    it { is_expected.to use_before_action(:expire_cart) }
  end

  describe "GET 'show'" do
    before do
      @user = FactoryGirl.create(:user, auth_token: 'abcdefgh')
      @product = FactoryGirl.create(:product)
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
    end

    it 'should fail auth when auth token is not present' do
      get :show, { id: @cart.id }
      expect(json).to eq({"message"=>"Auth Token not provided."})
      expect(response.status).to eq(401)
    end

    it 'should not auth when auth token is invalid' do
      set_headers('xyz')
      get :show, { id: @cart.id}
      expect(json).to eq({"message"=>"Unauthorized."})
      expect(response.status).to eq(401)
    end

    it 'render cart on success' do
      set_headers(@user.reload.auth_token)
      get :show, { id: @cart.id }
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'summary'" do
    before do
      @user = FactoryGirl.create(:user, auth_token: 'abcdefgh')
      @product = FactoryGirl.create(:product)
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart, product: @product)
    end

    it 'should fail auth when auth token is not present' do
      get :summary
      expect(json).to eq({"message"=>"Auth Token not provided."})
      expect(response.status).to eq(401)
    end

    it 'should not auth when auth token is invalid' do
      set_headers('xyz')
      get :summary
      expect(json).to eq({"message"=>"Unauthorized."})
      expect(response.status).to eq(401)
    end

    it 'render cart summary on success' do
      set_headers(@user.reload.auth_token)
      get :summary
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq ([{"product_name"=> @product.name, "quantity"=>1, "total_price"=>100}])
    end
  end
end