module MotionResource
  class Config
    attr_accessor :base_url 

    def self.base_url
      @@base_url ||= "http://localhost:3000/"
    end

    def self.base_url=(value)
      @@base_url = value
    end
  end
end