class MqService
  class << self
    def get_coords(state)
      response = MqClient.fetch('/geocoding/v1/address', { location: state })
      response[:results].last[:locations].first[:latLng]
    end

    def get_route(from, to)
      response = MqClient.fetch('/directions/v2/route', { from: from, to: to })
    end
  end
end
