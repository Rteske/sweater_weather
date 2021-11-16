class ForecastShort
  attr_reader :summary, :tempature
  def initialize(summary, tempature)
    @summary = summary
    @tempature = tempature
  end
end
