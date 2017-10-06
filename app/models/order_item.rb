class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def as_json(options={})
    super
    .slice(*['id', 'quantity'])
    .merge(product_name: self.product.name)
    .merge(price: self.product.price)
    .merge(total_price: self.total_price)
  end

  def total_price
    quantity * price
  end
end
