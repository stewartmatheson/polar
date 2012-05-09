module RenrenAPI
  module Error
    class HTTPError < StandardError
      def initialize(status)
        @status = status
        super(to_s)
      end
      
      def to_s
        "HTTP Error - the request returnd:(#{@status})"
      end
    end
  end
end
