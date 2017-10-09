require 'spec_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "Post 'create'" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'user not found' do
      post :create
      expect(json).to eq({"message"=>"User not found"})
    end

    it 'not valid password' do
      post :create, {email: @user.email, password: 'A12345678' }
      expect(json).to eq({"message"=>"User credentails are not valid"})
    end

    it 'should not set auth token' do
      user = FactoryGirl.create(:user, auth_token: nil)
      allow_any_instance_of(User).to receive(:generate_authentication_token!).and_return(nil)
      post :create, {email: user.email, password: user.password }
      expect(json).to eq({"message"=>"Could not set auth token"})
    end

    it 'success' do
      user = FactoryGirl.create(:user, auth_token: nil)
      post :create, {email: user.email, password: user.password }
      expect(json).to eq({"email"=>user.email, "auth_token"=>user.reload.auth_token})
    end
  end
end