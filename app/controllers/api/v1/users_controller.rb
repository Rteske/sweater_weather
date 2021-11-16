class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      user.api_keys.create! token: SecureRandom.hex
      user.api_key = user.api_keys.first.token
      json_string = Api::V1::UserSerializer.new(user).serializable_hash.to_json
      render json: json_string
    else
      render json: user.errors.messages, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
