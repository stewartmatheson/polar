module Polar
  class Response < Polar::Base
    def initialize(data)
      super(data)
    end

    def success
      @data["result"] == 1
    end
  end
end
