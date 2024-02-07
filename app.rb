require 'sinatra'
require 'slim'

users = []

get "/" do
  slim :index
end 

get "/login" do
  slim :login
end 

get '/users' do
  users.map {|u| slim :userlist, {locals:u}}
end

get "/userform" do
  slim :adduser
end

post "/user" do
  n=params['name']
  e=params['email']
  users.push({name:n,email:e})
  slim :adduser
end

post "/useropt" do
  mail=params['mail']
  p mail
  user=users.find {|u| u[:email]==mail}
  if user
    slim :useropt,{locals:user}
  else
    p "user does not exist"
  end
end

post "/useredit" do
  n=params['name']
  e=params['email']
  user={name:n,email:e}
  slim :useredit ,{locals:user}
end
