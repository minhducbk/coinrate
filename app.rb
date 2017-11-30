require 'sinatra'
require 'sinatra/activerecord'
require './controllers/application_controller.rb'
require_relative 'config/application'

set :database_file, 'config/database.yml'
#!/usr/bin/env ruby

require 'sinatra'

configure {
  set :server, :puma
  set :server_settings, {:config_files => "-"}
}