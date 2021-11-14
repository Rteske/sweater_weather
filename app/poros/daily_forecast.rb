class DailyForecast
  def initialize(params)
    @date = unix_to_datetime(params[:dt]).strftime('%F')
    @sunrise = unix_to_datetime(params[:sunrise]).strftime('%F %T %z')
    @sunset = unix_to_datetime(params[:sunset]).strftime('%F %T %z')
    @max_temp = params[:temp][:max]
    @min_temp = params[:temp][:min]
    @conditions = params[:weather].first[:description]
    @icon = params[:weather].first[:icon]
  end

  def unix_to_datetime(dt)
    Time.at(dt).to_datetime
  end
end
