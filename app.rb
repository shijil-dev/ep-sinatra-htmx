require 'sinatra'
require 'slim'

get "/" do
  slim :index
end 

get "/login" do
  slim :login
end 

get '/users' do
  slim :userlist
end

get "/userform" do
  slim :adduser
end
