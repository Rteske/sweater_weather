class OwService
  class << self
    def get_forecast(coords)
      body = { lat: coords[:lat], lon: coords[:lng], exclude: 'minutely,alerts', units: 'imperial' }
      OwClient.fetch('/data/2.5/onecall', body)
    end
  end
end
