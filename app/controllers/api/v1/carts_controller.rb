class Api::V1::CartsController < Api::V1::ApiController

  before_action :expire_cart, only: [:show]
  
  def show
    render json: @cart, status: 200
  end

  def cart_summary
    @data = Cart.summary_data
    render json: @data.as_json(only: ['cart_summary']), status: 200
  end
end