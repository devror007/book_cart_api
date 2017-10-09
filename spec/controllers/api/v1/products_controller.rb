require 'spec_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe "GET 'index'" do
    
    it 'render no content on success' do
      get :index
      expect(response.status).to eq(204)
    end

    it 'render products list on success' do
      FactoryGirl.create(:product)
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq ([{"name"=>"product1", "price"=>"100.0", "quantity"=>nil}])
    end
  end
end