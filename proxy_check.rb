#!/usr/bin/env ruby

require 'rubygems'
require 'restclient'
require 'json'

puts ARGV.size != 0 ? '' : <<-EOF

POST Proxy Checker Script
usage: proxy_check url-of-host.org url-to-post-to.net

Constantly checks a URL for a POSTed payload; when the UUID of the payload changes fire off a POST to a given URL with the data.

EOF

# TODO encrypt ;) simple.. just add the same salt to both scripts

def log(str); puts "[#{Time.now}] #{str}"; end

last_uuid     = false
url_to_check  = ARGV.first
url_to_hit    = ARGV.last # typically localhost
wait_time     = 5 # number of seconds between checks

while true do
  # log "-> #{url_to_check}"
  response = RestClient.get url_to_check
  response = JSON.parse response
  if response['proxy_request_uuid'] != last_uuid
    # log "New UUID! #{response['proxy_request_uuid']}"
    log "Forwarding POST to #{url_to_hit}"
    RestClient.post url_to_hit, response 
    last_uuid = response['proxy_request_uuid']
  end
  sleep wait_time
end