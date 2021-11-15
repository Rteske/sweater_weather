class Api::V1::CurrentForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :datetime, :sunrise, :sunset, :tempature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon
end
