class Api::V1::ForecastController < ApplicationController
  def show
    forecast = Api::V1::ForecastFacade.forecast(params)
    render json: { data: { id: 'null', type: 'forecast', attributes: forecast } }
  end
end
