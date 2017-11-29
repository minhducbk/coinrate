require 'rubygems'
require 'sinatra'
require 'redis'
require 'uri'
# Configure for redis cache 
$redis = Redis.new(:host => "localhost", :port => 6379)
#$redis ||= Redis.connect
