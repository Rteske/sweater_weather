class OwClient
  class << self
    def fetch(url, body)
      response = conn.get(url + api_key, body)
      parse(response)
    end

    private

    def api_key
      "?key=#{ENV['ow_api_key']}"
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new('https://api.openweathermap.org')
    end
  end
end
