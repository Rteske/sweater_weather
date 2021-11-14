class HourlyForecast
  def initialize(params)
    @time = unix_to_datetime(params[:dt])
    @tempature = params[:temp]
    @conditions = params[:weather].first[:description]
    @icon = params[:weather].first[:icon]
  end

  def unix_to_datetime(dt)
    Time.at(dt).to_datetime.strftime('%T')
  end
end
