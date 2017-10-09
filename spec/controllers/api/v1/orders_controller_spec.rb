require 'spec_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'before actions' do
    it { is_expected.to use_before_action(:expire_cart) }
  end

  describe "Post 'create'" do
    before do
      @user = FactoryGirl.create(:user, auth_token: 'abcdefgh')
      @product = FactoryGirl.create(:product)
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart)
    end

    it 'should fail auth when auth token is not present' do
      post :create
      expect(json).to eq({"message"=>"Auth Token not provided."})
      expect(response.status).to eq(401)
    end

    it 'should not auth when auth token is invalid' do
      set_headers('xyz')
      post :create
      expect(json).to eq({"message"=>"Unauthorized."})
      expect(response.status).to eq(401)
    end

    it 'render order on success' do
      set_headers(@user.reload.auth_token)
      post :create
      expect(response.status).to eq(200)
      expect(json['message']).to eq("Thanks, your order placed successfully")
    end

    it 'render cart item erros if not saved cart item' do
      allow_any_instance_of(Order).to receive(:save).and_return(false)
      set_headers(@user.auth_token)
      post :create
      expect(json['message']).to eq('Sorry, could not place order')
      expect(response.status).to eq(422)
    end
  end

  describe "GET 'index'" do
    before do
      @user = FactoryGirl.create(:user, auth_token: 'abcdefgh')
      @product = FactoryGirl.create(:product)
      @cart = FactoryGirl.create(:cart, user: @user)
      @cart_item = FactoryGirl.create(:cart_item, cart: @cart, product: @product)
      @order = FactoryGirl.create(:order, user: @user)
    end

    it 'should fail auth when auth token is not present' do
      get :index
      expect(json).to eq({"message"=>"Auth Token not provided."})
      expect(response.status).to eq(401)
    end

    it 'should not auth when auth token is invalid' do
      set_headers('xyz')
      get :index
      expect(json).to eq({"message"=>"Unauthorized."})
      expect(response.status).to eq(401)
    end

    it 'render order on success' do
      set_headers(@user.reload.auth_token)
      get :index
      expect(response.status).to eq(200)
    end
  end
end