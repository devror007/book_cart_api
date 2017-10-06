class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy

  after_create :delete_cart

  def as_json(options={})
    super
    .slice(*['id'])
    .merge(order_items: self.order_items)
    .merge(total_amount: self.total_price)
  end

  def confirm
    self.user.cart_items.each do |cart_item|
      order_item = self.order_items.build(quantity: cart_item.quantity, price: cart_item.product.price, product_id: cart_item.product_id)
    end
    self.save
  end

  def total_price
    self.order_items.map(&:total_price).sum
  end

  private

    def delete_cart
      self.user.cart.destroy
    end
end