class Api::V1::BackgroundFacade
  class << self
    def background(city)
      results = UnsplashService.get_background_pic(city)
      credits = ImageCredit.new('https://api.unsplash.com', results[:results].first[:user][:username], 'https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_170,w_170,f_auto,b_white,q_auto:eco,dpr_1/tbvbvipimh2camf5nb2q')
      image = Image.new(city, results[:results].first[:urls][:raw], credits)
      CityBackground.new(image)
    end
  end
end
