require 'spec_helper'

describe Polar::Cursor do
  let(:api_key) { "api_key" }
  let(:secret_key) { "secret_key" }
  let(:session_key) { "session_key" }
  
  subject { Polar::Client.new(api_key, secret_key, session_key).get_friends }

  before do 
    Timecop.freeze(Time.now)
    Stubs::GetLotsOfFriends.new 
  end
  
  it do
    subject.class.should eql Polar::Cursor
    
    total_users = []
    while subject.next_page?
      subject.each do |user|
       total_users << user 
      end
    end

    #When we spec out pages we make the last page empty. Thats why this number is 499
    total_users.count.should eql 49 * 500
    
  end
end
