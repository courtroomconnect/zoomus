# frozen_string_literal: true
require 'delegate'
require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler/setup'
require 'zoom'
require 'webmock/rspec'

RSpec.configure do |config|
  # some (optional) config here
end

def fixture(*path, filename)
  File.join('spec', 'fixtures', path, filename)
end

def json_response(*path, endpoint)
  open(fixture(path, endpoint + '.json')).read
end

def zoom_url(url)
  /https:\/\/api.zoom.us\/v2#{url}.*/
end

def jwt_client
  Zoom.new
end

def oauth_client
  Zoom::Client::OAuth.new(access_token: 'xxx', timeout: 15)
end

def zoom_client
  jwt_client
end

def filter_key(hash, key)
  copy = hash.dup
  copy.delete(key)
  copy
end
