FactoryGirl.define do
  factory :product, class: Product do
    sequence(:name) { |n| "product#{n}" }
    price 100
  end
end