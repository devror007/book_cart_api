FactoryGirl.define do
  factory :user, class: User do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'p@ssw0rd'
    password_confirmation 'p@ssw0rd'
    auth_token SecureRandom.hex(4)
  end
end