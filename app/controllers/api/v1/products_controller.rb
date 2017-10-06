class Api::V1::ProductsController < Api::V1::ApiController
  skip_before_filter :authenticate_user!

  def index
    @products = Product.all
    if @products.count > 0
      render json: @products.as_json(only: [:name, :price, :quantity]), status: 200
    else
      render json: [], status: 204
    end
  end
end
