# encoding: UTF-8
require "json"
require "faraday"
require "faraday_middleware"

module Polar
  class Request

    attr_reader :response

    def initialize(api_key, secret_key, session_key, params)
      @api_key, @session_key, @secret_key = api_key, session_key, secret_key

      conn = Faraday.new(:url => Polar::BASE_URL) do |c|
        c.use Faraday::Request::UrlEncoded
        c.use Faraday::Adapter::NetHttp
      end

      conn.headers["Content-Type"] = ["application/x-www-form-urlencoded"];
      params[:api_key] = @api_key
      params[:call_id] = Time.now.to_i 
      params[:session_key] = @session_key
      params[:format] = "JSON"
      params[:sig] = SignatureCalculator.new(@secret_key).calculate(params)

      raw_response = conn.post do |request|
        request.body = urlencode_params(params)
      end

      raise Polar::Error::HTTPError.new(raw_response.status) if (400..599).include?(raw_response.status)
      @response = JSON.parse(raw_response.body)
      raise Polar::Error::APIError.new(@response) if renren_api_error?
    end

    private

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

    def renren_api_error?
      return false if @response.class == Array
      @response.has_key?("error_code") && @response.has_key?("error_msg")
    end

  end
end
