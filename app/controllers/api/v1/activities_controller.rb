class Api::V1::ActivitiesController < ApplicationController
  def index
    params[:location] = params[:destination]
    activities = Api::V1::ActivitiesFacade.activities_by_location(params[:location])
    render json: { data: { id: 'null', type: 'activities', attributes: activities } }
  end
end
