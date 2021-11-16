class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user.authenticate(session_params[:password])
      user.api_key = user.api_keys.first.token
      render json: Api::V1::UserSerializer.new(user)
    else
      render json: 'bad credentials', status: 401
    end
  rescue
    render json: 'bad credentials', status: 401
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
