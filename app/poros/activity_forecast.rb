class ActivityForecast
  attr_reader :destination, :forecast, :activities

  def initialize(destination, forecast, activities)
    @destination = destination
    @forecast = forecast
    @activities = activities
  end
end
