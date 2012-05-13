require 'webmock'

class EndPointStub
  
  include WebMock::API

  def initialize
    stub_request(:post, "http://api.renren.com/restserver.do").to_return(response)
  end

  def response; raise("Abstract Method"); end;
end

module RenrenStubs
  class GetFriends < EndPointStub
    def response
      #The following is a list of 5 friends as renren would return them
      response_body = """
      [{\"id\":458760882,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn521/20120508/0915/h_tiny_768l_5f460007d2ae2f75.jpg\",\"sex\":\"1\",\"name\":\"\xE5\x90\x89\xE5\xA5\xA5\",\"headurl\":\"http://hdn.xnimg.cn/photos/hdn521/20120508/0915/h_head_Yy6m_5f460007d2ae2f75.jpg\"},{\"id\":458763929,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn521/20120508/0940/h_tiny_MQwM_259c0000499f2f76.jpg\",\"sex\":\"0\",\"name\":\"\xE9\x99\x88\xE7\x8E\xB2\",\"headurl\":\"http://hdn.xnimg.cn/photos/hdn521/20120508/0940/h_head_BNLj_259c0000499f2f76.jpg\"},{\"id\":458752264,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn221/20120508/0720/h_tiny_Z72T_25a6000047842f76.jpg\",\"sex\":\"1\",\"name\":\"\xE6\x88\x91\xE4\xB8\xBA\xE7\x90\x83\xE7\x8B\x82\",\"headurl\":\"http://hdn.xnimg.cn/photos/hdn221/20120508/0720/h_head_pj3r_25a6000047842f76.jpg\"},{\"id\":458756209,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn321/20120508/0825/tiny_ggcN_8454n019117.jpg\",\"sex\":\"0\",\"name\":\"\xE8\x82\x96\xE5\xB9\xB4\",\"headurl\":\"http://hdn.xnimg.cn/photos/hdn421/20120508/0825/h_head_7AyN_5f4b0007d83a2f75.jpg\"},{\"id\":458759081,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn221/20120508/0855/h_tiny_9VHt_25a3000048f02f76.jpg\",\"sex\":\"0\",\"name\":\"\xE8\xB0\xA2\xE4\xB8\xBD\xE5\xB0\x94\",\"headurl\":\"http://hdn.xnimg.cn/photos/hdn221/20120508/0855/h_head_CWBN_25a3000048f02f76.jpg\"},{\"id\":458760413,\"tinyurl\":\"http://head.xiaonei.com/photos/0/0/men_tiny.gif\",\"sex\":\"1\",\"name\":\"\xE6\x8B\x89\xE6\x9D\xB0\xE4\xBB\x80\",\"headurl\":\"http://head.xiaonei.com/photos/0/0/men_head.gif\"}]
      """
      { :body => response_body }
    end
  end

  class GetUser < EndPointStub
    def response
      response_body = """
      [{\"uid\":449545842,\"tinyurl\":\"http://hdn.xnimg.cn/photos/hdn321/20120430/0850/h_tiny_7KQT_563e0006d3dc2f76.jpg\",\"name\":\"\xE9\x99\xB3\xE6\xB8\xAF\xE7\x94\x9F\"}]
      """
      { :body => response_body }
    end
  end
end
