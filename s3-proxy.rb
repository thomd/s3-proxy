require 'rubygems'
require 'sinatra'
require 'open-uri'

class S3Proxy < Sinatra::Base

  set :app_file, __FILE__

  s3_url = 'http://cdn.thomd.net.s3.amazonaws.com'

  configure do
  end

  before do
    ttl = 31536000  # one yearin seconds
    headers 'Cache-Control'               => "public, max-age=#{ttl}",
            'Expires'                     => (Time.now + ttl).httpdate,
            'Access-Control-Allow-Origin' => '*.thomd.net'
  end

  get '/:font_face.css' do
    headers['Content-Type'] = 'text/css'
    open("#{s3_url}/#{params[:font_face]}.css").read
  end

  get '/:folder/:font' do
    headers['Content-Type'] = case params[:font]
      when /\.ttf$/  then 'font/truetype'
      when /\.otf$/  then 'font/opentype'
      when /\.woff$/ then 'font/woff'
      when /\.eot$/  then 'application/vnd.ms-fontobject'
      when /\.svg$/  then 'image/svg+xml'
    end
    open("#{s3_url}/#{params[:folder]}/#{params[:font]}").read
  end
end
