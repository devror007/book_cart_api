require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:cart_items) }
    it { should have_one(:cart).dependent(:destroy) }
  end

  describe 'instance methods' do
    describe 'generate_authentication_token!' do
      before do
        @user = FactoryGirl.create(:user)
      end

      it 'should set auth token to user' do
        expect(@user.generate_authentication_token!).not_to eq(nil)
      end
    end

    describe 'reset_auth_token!' do
      before do
        @user = FactoryGirl.create(:user, auth_token: 'abcdfgeefef')
      end

      it 'should clear the auth token to for user' do
        @user.reset_auth_token!
        expect(@user.auth_token).to eq(nil)
      end
    end
  end
end