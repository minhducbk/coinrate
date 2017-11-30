app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
# rackup "#{app_dir}/config.ru"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"

require 'sinatra/activerecord'
ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
