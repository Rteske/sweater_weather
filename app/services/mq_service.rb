class MqService
  class << self
    def get_coords(state)
      response = MqClient.fetch('/geocoding/v1/address', { location: state })
      response[:results].last[:locations].first[:latLng]
    end
  end
end
