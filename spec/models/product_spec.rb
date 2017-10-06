require 'spec_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items) }
    it { should have_many(:order_items) }
  end
end