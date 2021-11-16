class Api::V1::RoadTripController < ApplicationController
  before_action :verify_api_key!

  def index
    road_trip = Api::V1::RoadTripFacade.route_forecast(params[:origin], params[:destination])

    render json: { data: { id: 'null', type: 'road trip', attributes: road_trip} }
  end
end
