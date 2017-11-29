$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'slim'
require 'v8'
require 'sinatra/auth'
require 'sinatra/contact'
require 'sinatra/flash'
require 'asset-handler'
Dir.glob('./{models,helpers,controllers,config}/*.rb').each { |file| require file }

class ApplicationController < Sinatra::Base
  include Response
  include ExceptionHandler

  helpers ApplicationHelpers

  get '/exchange_rates' do
    ExchangeRate.all.map{|rate| rate.slice("origin_currency", "exchanged_currency", "rate")}.to_json
  end

  run! if app_file == $0
end