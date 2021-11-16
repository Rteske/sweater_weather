class Image
  attr_reader :location, :image_url, :credit
  def initialize(location, image_url, credit)
    @location = location
    @image_url = image_url
    @credit = credit
  end
end
