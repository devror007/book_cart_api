class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  scope :active, -> { where("carts.updated_at >= ?", Time.now-2.days) }

  def as_json(options={})
    if options[:only] == ['cart_summary']
      super
      .slice(*[])
      .merge(product_name: self.product_name)
      .merge(quantity: self.quantity)
      .merge(total_price: self.total)
    else
      super
      .slice(*['id'])
      .merge(cart_items: self.cart_items)
      .merge(user_email: self.user.email)
      .merge(total_amount: self.total_price)
    end
  end

  def add_products(product)
    current_item = cart_items.find_or_initialize_by(product_id: product.id)
    current_item.price = product.price
    current_item.quantity += 1
    current_item
  end

  def self.summary_data
    Cart.active.joins(cart_items: :product).select("cart_items.product_id, sum(cart_items.quantity) as quantity, sum(products.price * cart_items.quantity) as total, products.name as product_name" ).group(:product_id)
  end

  def is_expired?
    self.updated_at < 2.days.ago if self.updated_at
  end

  def total_price
    cart_items.map(&:total_price).sum
  end
end
