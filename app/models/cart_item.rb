class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, touch: true

  def initialize(attr={})
    super
    self.quantity = 0
  end

  def total_price
    quantity * product.price
  end

  def price_change?
    price != product.price
  end

  def as_json(options={})
    super
    .slice(*['id', 'quantity'])
    .merge(product_name: self.product.name)
    .merge(price: self.product.price)
    .merge(total_price: self.total_price)
  end
end
