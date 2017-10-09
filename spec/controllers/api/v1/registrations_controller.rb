require 'spec_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe "Post 'create'" do

    it 'should create user' do
      post :create, {user: {email: 'user@gmail.com', password: '12345678', password_confirmation: '12345678' }}
      expect(json).to eq({"message"=>"Thank you for registration, please sign in to continue"})
    end

    it 'should render error for invalid email' do
      FactoryGirl.create(:user, email: 'user@gmail.com')
      post :create, {user: {email: 'user@gmail.com', password: '12345678', password_confirmation: '12345678' }}
      expect(json).to eq({"errors"=>{"email"=>["has already been taken"]}})
    end
  end
end