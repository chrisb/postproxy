#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'json'
@@last_request = {}
post('/')       { @@last_request = params.merge :proxy_request_uuid => Time.now.to_i }
get('/proxy')   { @@last_request.to_json }