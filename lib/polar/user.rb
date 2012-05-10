module Polar
  class User < Polar::Base
    def initialize(data)
      super(data)
    end

    def avatar
      tinyurl
    end

    def to_h
      @data.merge({ "avatar" => @data["tinyurl"]})
    end
  end
end
