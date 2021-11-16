class ImageCredit
  attr_reader :source, :author, :logo
  def initialize(source, author, logo)
    @source = source
    @author = author
    @logo = logo
  end
end
