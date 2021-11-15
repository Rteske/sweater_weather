class BoredClient
  class << self
    def fetch(url, body)
      response = conn.get(url, body)
      parse(response)
    end

    private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new('http://www.boredapi.com')
    end
  end
end
