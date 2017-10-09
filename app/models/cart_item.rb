class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, touch: true

  validates :product_id,
   presence: true

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
    json_data = super
    .slice(*['id', 'quantity'])
    .merge(product_name: self.product.name)
    .merge(price: self.product.price)
    .merge(total_price: self.total_price)
    json_data.merge(price_alert: "price change from #{self.price} to #{self.product.price}") if price_change?
    json_data
  end
end
