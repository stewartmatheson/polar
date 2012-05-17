module Stubs
  class GetUser < EndPointStub
    def response(page_number)
      response_body = """
      [{\"uid\":449545842,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn321/20120430/0850/h_tiny_7KQT_563e0006d3dc2f76.jpg\",\"name\":\"\xE9\x99\xB3\xE6\xB8\xAF\xE7\x94\x9F\"}]
      """
      { :body => response_body }
    end
  end
end 
