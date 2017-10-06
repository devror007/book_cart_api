class Product < ActiveRecord::Base
  belongs_to :cart_item
  belongs_to :order_item
end
