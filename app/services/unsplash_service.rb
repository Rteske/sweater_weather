class UnsplashService
  class << self
    def get_background_pic(city)
      body = { query: "#{city} Skyline", page: 1, per_page: 1 }
      UnsplashClient.fetch('/search/photos', body)
    end
  end
end
