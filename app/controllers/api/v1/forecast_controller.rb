class Api::V1::ForecastController < ApplicationController
  def show
    stuff = ForecastFacade.forecast(params)
    render json: stuff
  end
end
