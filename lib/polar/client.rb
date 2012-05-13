# encoding: UTF-8

require "zlib"
require "json"
require "faraday"
require "faraday_middleware"

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
      
      user_info =  request(params)
      if user_info.count == 1 
        return Polar::User.new(user_info.first)
      else
        friend_list = []
        request(params).each { |current_user| friend_list << Polar::User.new(current_user) }
        return friend_list
      end
    end

    def set_status(status)
      params = {
        :method => "status.set",
        :v => "1.0",
        :status => status
      }
      request(params, :post)
    end

    private

    def current_time_in_milliseconds
      "%.3f" % Time.now.to_f
    end

    def request(params)
      conn = Faraday.new(:url => Polar::BASE_URL) do |c|
        c.use Faraday::Request::UrlEncoded
        c.use Faraday::Response::Logger
        c.use Faraday::Adapter::NetHttp
      end

      conn.headers["Content-Type"] = ["application/x-www-form-urlencoded"];
      params[:api_key] = @api_key
      params[:call_id] = Time.now.to_i 
      params[:session_key] = @session_key
      params[:format] = "JSON"
      params[:sig] = SignatureCalculator.new(@secret_key).calculate(params)

      response = conn.post do |request|
        request.body = urlencode_params(params)
      end

      raise RenrenAPI::Error::HTTPError.new(response.status) if (400..599).include?(response.status)
      parsed_response = JSON.parse(response.body)
      raise RenrenAPI::Error::APIError.new(parsed_response) if renren_api_error?(parsed_response)
      parsed_response
    end

    def renren_api_error?(response_body)
      return false if response_body.class == Array 
      response_body.has_key?("error_code") && response_body.has_key?("error_msg")
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
end
