$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'active_support/all'
require "sinatra/json"
require 'slim'
# require 'rack/throttle'
# use Rack::Throttle::Daily, max: 2500

Dir.glob('./{models,helpers,controllers,config}/*.rb').each { |file| require file }
Dir.glob('./controllers/concerns/*.rb').each { |file| require file }

class ApplicationController < Sinatra::Base
  include Response
  include ExceptionHandler
  include ApplicationHelper

  get '/exchange-rates' do
    content_type :json
    # Load rates from database    
    # @rates = ExchangeRate.all.map{|rate| rate.slice("origin_currency", "exchanged_currency", "rate")}.to_json 
        
    # Load rates from redis cache    
    @rates = JSON.parse($redis.get("exchange_rates")).map{|rate| 
                        rate.slice("origin_currency", "exchanged_currency", "rate")}.to_json
    @rates
  end

  run! if app_file == $0
end