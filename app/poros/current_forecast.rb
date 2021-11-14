class CurrentForecast
  attr_reader :datetime, :sunrise, :sunset, :tempature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon
  def initialize(params)
    @datetime = unix_to_datetime(params[:dt])
    @sunrise = unix_to_datetime(params[:sunrise])
    @sunset = unix_to_datetime(params[:sunset])
    @tempature = params[:temp]
    @feels_like = params[:feels_like]
    @humidity = params[:humidity]
    @uvi = params[:uvi]
    @visibility = params[:visibility]
    @conditions = params[:weather].first[:description]
    @icon = params[:weather].first[:icon]
  end

  def unix_to_datetime(dt)
    Time.at(dt).to_datetime.strftime('%F %T %z')
  end
end
