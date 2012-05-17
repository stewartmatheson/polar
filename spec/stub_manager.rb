require 'webmock'

class EndPointStub
  include WebMock::API

  def initialize
    WebMock.reset!
    if @pages
      @pages.times do |count|
        stub_request(:post, "http://api.renren.com/restserver.do").with(:body => request_body_with_page(count + 1)).to_return(response(count + 1))
      end
    else
      stub_request(:post, "http://api.renren.com/restserver.do").to_return(response(1))
    end
  end

  def with
    {}
  end

  def response
    raise("Abstract Method")
  end
    
  private

  def request_body_with_page
    raise("Abstract Method")
  end

  def urlencode_params(params_hash)
    params = ''
    stack = []

    params_hash.each do |k, v|
      if v.is_a?(Hash)
        stack << [k,v]
      else
        params << "#{k}=#{v}&"
      end
    end

    stack.each do |parent, hash|
      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << ["#{parent}[#{k}]", v]
        else
          params << "#{parent}[#{k}]=#{v}&"
        end
      end
    end

    params.chop! # trailing &
    params
  end
end
