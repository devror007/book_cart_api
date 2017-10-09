class Api::V1::CartItemsController < Api::V1::ApiController
  before_action :expire_cart
  before_action :set_cart_item, only: [:destroy, :update]

  def create
    product = Product.find_by_id(params[:product_id])
    if product
      cart_item = @cart.add_products(product)
      if cart_item.save
        render json: @cart, status: 200
      else
        render json: {current_cart: @cart, message: 'sorry, could not add to cart', errors: cart_item.errors}, status: 422
      end
    else
      render json: {current_cart: @cart, message: 'Product not found'}, status: 404
    end
  end

  def update
    if @cart_item
      @cart_item.quantity = params[:quantity].to_i
      if @cart_item.save
        render json: @cart, status: 200
      else
        render json: {current_cart: @cart, message: 'sorry, could not update cart item quantity', errors: @cart_item.errors}, status: 422
      end
    else
      render json: {current_cart: @cart, message: 'Cart item not found'}, status: 404
    end
  end

  def destroy
    if @cart_item
      if @cart_item.destroy
        render json: @cart, message: 'Cart item Removed from the cart', status: 200
      else
        render json: { current: @cart, message: 'Sorry, could not removed cart item from cart', errors: @cart_item.errors}, status: 422
      end
    else
      render json: { current_cart: @cart, message: 'Cart Item Not found' }, status: 404
    end
  end

  private

    def set_cart_item
      @cart_item = CartItem.find_by_id(params[:id])
    end
end