class Api::V1::OrdersController < Api::V1::ApiController

  before_action :expire_cart, only: [:create]

  def index
    orders = @user.orders
    render json: orders
  end

  def create
    order = @user.orders.build
    if order.confirm!
      render json: { order_details: order, message: 'Thanks, your order placed successfully' }, status: 200
    else
      render json: { message: 'Sorry, could not place order', errors: order.errors }, status: 422
    end
  end
end
