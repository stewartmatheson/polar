module Stubs
  class SetStatus < EndPointStub
    def response(page_number)
      response_body = "{\"result\":1}"
      { :body => response_body }
    end
  end
end
