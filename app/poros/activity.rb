class Activity
  attr_reader :title, :type, :participants, :price
  
  def initialize(title, type, participants, price)
    @title = title
    @type = type
    @participants = participants
    @price = price
  end
end
