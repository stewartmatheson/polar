require File.expand_path(File.dirname(__FILE__) + '/../lib/polar')

require "json"
require "net/http"
require "zlib"
require "stringio"
require "uuidtools"
require "digest/md5"
require 'rack/test'
require 'ruby-debug'
require 'webmock'
require 'webmock/rspec'

require "polar"
require "stub_manager"

module Helpers
  def generate_hash(secret_key, api_key, hash = {})
    auth_code = Digest::MD5.hexdigest(hash.sort.collect { |e| e * "=" } * "" << secret_key)
    Hash[hash.collect { |k, v| [api_key + "_" + k, v] }].merge!(api_key => auth_code)
  end

  def generate_cookie(secret_key, api_key, hash = {})
    generate_hash(secret_key, api_key, hash).collect { |(k, v)| "#{k}=#{v}" }
  end
end

