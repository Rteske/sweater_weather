class MqService
  class << self
    def get_forecast(coords)
      response = OwClient.fetch('/geocoding/v1/address', { lat: coords[:lat], lon: coords[:lon] })
      response
    end
  end
end
