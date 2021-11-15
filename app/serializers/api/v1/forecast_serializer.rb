class Api::V1::ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast

  has_one :current_forecast
  has_many :daily_forecast
  has_many :hourly_forecast
end
