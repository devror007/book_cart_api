class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    user = User.find_by_email(params[:email])
    if user
      if user.valid_password?(params[:password])
        if user.generate_authentication_token!
          render json: user.reload.as_json(only: [:email, :auth_token]), status: 200
        else
          render json: { message: 'Could not set auth token' }, status: 422
        end
      else
        render json: { message: 'User credentails are not valid' }, status: 403
      end
    else
      render json: { message: 'User not found' }, status: 404
    end
  end

  def destroy
    if @user.reset_auth_token!
      render json: { message: 'sign out successfully' }, status: 200
    else
      render json: { message: 'Sorry, could not sign out' }, status: 422
    end
  end
end
