# encoding: UTF-8

require 'polar/signature_calculator'
require 'polar/authentication'
require 'polar/client'
require 'polar/error/http_error'
require 'polar/error/api_error'

module Polar
  BASE_URL = "http://api.renren.com/restserver.do"
  VERSION = [0, 4]

  def self.version
    VERSION * "."
  end
end
