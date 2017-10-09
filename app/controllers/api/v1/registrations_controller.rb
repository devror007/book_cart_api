class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_filter :authenticate_user!

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'Thank you for registration, please sign in to continue' }, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    def user_params
      params.require(:user).permit([:email, :password, :password_confirmation])
    end
end
