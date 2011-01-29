require 'rubygems'
require 's3-proxy'
require 'bundler'
Bundler.require

# gzip responses
# add HTTP header "Accept-Encoding: gzip,deflate" to request
use Rack::Deflater

run S3Proxy
