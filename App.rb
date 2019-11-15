require 'sinatra'
require "byebug"

get '/' do
  erb :index
end

post '/check_bike' do
    puts params
    "Hello World"
end
