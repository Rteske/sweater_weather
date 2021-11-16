class ApplicationController < ActionController::API
  def verify_api_key!
    if params[:api_key]
      key_param = ApiKey.find_by(token: params[:api_key])
      if key_param.nil?
        render status: :unauthorized
      end
    end
  rescue
    render status: :unauthorized
  end
end
