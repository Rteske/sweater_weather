class Api::V1::BackgroundsController < ApplicationController
  def index
    city = params[:location].split(',')
    city = city[0]
    background_image = Api::V1::BackgroundFacade.background(city)
    render json: { data: { id: 'null', type: 'image', attributes: background_image } }
  end
end
