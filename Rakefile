require_relative 'config/application'
require "sinatra/activerecord/rake"
Dir.glob('./models/*.rb').each { |model| require model }
Dir.glob('./tasks/*.rake').each { |r| load r }

namespace :db do
  task :load_config do
    require "./app"
  end
end

# Rails.application.load_tasks