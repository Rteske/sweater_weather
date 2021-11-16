class UnsplashClient
  class << self
    def fetch(url, body)
      response = conn.get(url + api_key, body)
      parse(response)
    end

    private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new('https://api.unsplash.com')
    end

    def api_key
      "?client_id=#{ENV['unsplash_api_key']}"
    end
  end
end
