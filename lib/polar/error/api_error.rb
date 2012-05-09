module RenrenAPI
  module Error
    class APIError < StandardError
      
      def initialize(error_response)
        @code, @message = error_response["error_code"], error_response["error_msg"]
      end

      def to_s
        "The Renren API has returned an Error:(#{@code} - #{@message})"
      end

    end
  end
end
