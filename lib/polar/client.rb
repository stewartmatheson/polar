module Polar
  class Client

    def initialize(api_key, secret_key, session_key)
      @api_key, @secret_key, @session_key = api_key, secret_key, session_key
    end

    def get_friends
      params = {
        :method => "friends.getFriends",
        :v => "1.0"
      }

      friend_list = []
      request(params).each { |current_user| friend_list << Polar::User.new(current_user) }
      friend_list
    end

    def get_info(uids, fields)
      params = {
        :method => "users.getInfo",
        :v => "1.0",
        :fields => fields * ",",
        :uids => uids * ","
      }
      
      user_info = request(params)
      if user_info.count == 1 
        return Polar::User.new(user_info.first)
      else
        friend_list = []
        user_info.each { |current_user| friend_list << Polar::User.new(current_user) }
        return friend_list
      end
    end

    def set_status(status)
      params = {
        :method => "status.set",
        :v => "1.0",
        :status => status
      }
      Polar::Response.new request(params) 
    end

    private

    def request(params)
      Polar::Request.new(@api_key, @secret_key, @session_key, params).response
    end

    def current_time_in_milliseconds
      "%.3f" % Time.now.to_f
    end

  end
end
