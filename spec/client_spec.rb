require "spec_helper"

describe Polar::Client, "#get_friends" do
  let(:api_key) { "api_key" }
  let(:secret_key) { "secret_key" }
  let(:session_key) { "session_key" }
  subject { described_class.new(api_key, secret_key, session_key).get_friends }
  before { RenrenStubs::GetFriends.new }

  it do 
    subject.class.should eql Array
    subject.first.class.should eql Polar::User
    subject.first.avatar.should eql "http://hdn.xnimg.cn/photos/hdn521/20120508/0915/h_tiny_768l_5f460007d2ae2f75.jpg"
    subject.first.to_h["avatar"].should eql "http://hdn.xnimg.cn/photos/hdn521/20120508/0915/h_tiny_768l_5f460007d2ae2f75.jpg"
  end
end

describe Polar::Client, "#get_info" do
  let(:api_key) { "f336414ab20d4073ae1bebd4ababdda0" }
  let(:secret_key) { "9f92400b4d4a460490ce96c6e651708b" }
  let(:session_key) { "6.b5fac2f430600263d1f5ea46d622eb69.2592000.1339128000-458912501" }
  subject { described_class.new(api_key, secret_key, session_key).get_info(uids, fields) }
  #before { RenrenStubs::GetUser.new }

  let(:fields) do
    %w{uid name tinyurl}
  end

  let(:uids) do
    [449545842]
  end

  it do
    subject.class.should eql Polar::User 
    subject.avatar.should eql "http://hdn.xnimg.cn/photos/hdn521/20120508/0915/h_tiny_768l_5f460007d2ae2f75.jpg"
  end
end

describe Polar::Client, "#send_notification" do
  subject { described_class.new(api_key, secret_key, session_key).send_notification(receiver_ids, notification) }
  let(:http) { Net::HTTP.new("api.renren.com") }
  let(:api_key) { "8802f8e9b2cf4eb993e8c8adb1e02b06" }
  let(:secret_key) { "34d3d1e26cd44c05a0c450c0a0f8147b" }
  let(:session_key) { "session_key" }

  let(:result) do
    {"result" => 1}
  end

  let!(:now) do
    Time.now
  end

  let(:receiver_ids) do
    [12345, 12346]
  end

  let(:params) do
    {
      :api_key => api_key,
      :method => "notifications.send",
      :call_id => "%.3f" % now.to_f,
      :v => "1.0",
      :session_key => session_key,
      :format => "JSON",
      :to_ids => receiver_ids * ",",
      :notification => notification
    }
  end

  let(:notification) do
    "test"
  end
  
  let(:form_params) do
    signature_calculator = Polar::SignatureCalculator.new(secret_key)
    signature = signature_calculator.calculate(params)
    URI.encode_www_form(params.merge(:sig => signature))
  end

  before :each do
    Time.stub(:now).and_return(now)
    response = mock(Net::HTTPResponse)
    gzip_writer = Zlib::GzipWriter.new(StringIO.new(buffer = ""))
    gzip_writer << JSON.generate(result)
    gzip_writer.close
    response.stub(:code => '200', :message => "OK", :content_type => "application/json", :body => buffer)
    http.should_receive(:post).with("/restserver.do", form_params, {"Accept-Encoding" => "gzip"}).once.and_return(response)
  end

  it { should == result }
end

describe Polar::Client, "#status_set" do
  subject { described_class.new(api_key, secret_key, session_key).set_status(status) }
  let(:http) { Net::HTTP.new("api.renren.com") }
  let(:api_key) { "8802f8e9b2cf4eb993e8c8adb1e02b06" }
  let(:secret_key) { "34d3d1e26cd44c05a0c450c0a0f8147b" }
  let(:session_key) { "session_key" }

  let(:result) do
    {"result" => 1}
  end

  let!(:now) do
    Time.now
  end

  let(:status) do
    "Hello, how are you toady?"
  end
  
  let(:params) do
    {
      :api_key => api_key,
      :method => "status.set",
      :call_id => "%.3f" % now.to_f,
      :v => "1.0",
      :session_key => session_key,
      :format => "JSON",
      :status => status
    }
  end

  let(:notification) do
    "test"
  end
  
  let(:form_params) do
    signature_calculator = Polar::SignatureCalculator.new(secret_key)
    signature = signature_calculator.calculate(params)
    URI.encode_www_form(params.merge(:sig => signature))
  end
  
  before :each do
    Time.stub(:now).and_return(now)
    response = mock(Net::HTTPResponse)
    gzip_writer = Zlib::GzipWriter.new(StringIO.new(buffer = ""))
    gzip_writer << JSON.generate(result)
    gzip_writer.close
    response.stub(:code => '200', :message => "OK", :content_type => "application/json", :body => buffer)
    http.should_receive(:post).with("/restserver.do", form_params, {"Accept-Encoding" => "gzip"}).once.and_return(response)
  end
  
  it { should == result }
end
