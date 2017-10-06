class Api::V1::ApiController < ActionController::Base

  before_filter :authenticate_user!
  before_filter :set_cart

  private

  def authenticate_user!
    user_token = request.headers['HTTP_AUTH_TOKEN']
    if user_token
      @user = User.find_by_auth_token(user_token)
      #Unauthorize if a user object is not returned
      if @user.nil?
        render json: {message: 'Unauthorized.'}, status: 401
      end
    else
      render json: {message: 'Auth Token not provided.'}, status: 401
    end
  end

  def unauthorize
    head status: :unauthorized
    return false
  end

  def set_cart
    @cart = @user.cart || Cart.new(user_id: @user.id) if @user
  end

  def expire_cart
    @cart.destroy if @cart && @cart.is_expired?
  end

end