class BoredService
  class << self
    def get_type_activity(type)
      body = { type: type }
      BoredClient.fetch('/api/activity', body)
    end
  end
end
