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
  let(:api_key) { "api_key" }
  let(:secret_key) { "secret_key" }
  let(:session_key) { "session_key" }
  subject { described_class.new(api_key, secret_key, session_key).get_info(uids, fields) }
  before { RenrenStubs::GetUser.new }

  let(:fields) do
    %w{uid name tinyurl}
  end

  let(:uids) do
    [449545842]
  end

  it do
    subject.class.should eql Polar::User 
    subject.avatar.should eql "http://hdn.xnimg.cn/photos/hdn321/20120430/0850/h_tiny_7KQT_563e0006d3dc2f76.jpg"
  end
end

describe Polar::Client, "#status_set" do
  let(:api_key) { "api_key" }
  let(:secret_key) { "secret_key" }
  let(:session_key) { "session_key" }

  let(:status) { "Hello, how are you toady?" }
  before { RenrenStubs::SetStatus.new }

  subject { described_class.new(api_key, secret_key, session_key).set_status(status) }
  
  it do
    subject.class.should eql Polar::Response
    subject.success.should eql true
  end
end
