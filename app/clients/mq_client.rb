class MqClient
  class << self
    def fetch(url, body)
      response = conn.get(url + api_key, body)
      parse(response)
    end

    private

    def api_key
      "?key=#{ENV['mq_api_key']}"
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new('http://www.mapquestapi.com')
    end
  end
end
