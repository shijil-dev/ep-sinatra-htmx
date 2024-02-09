require 'sinatra'
require 'slim'

users = []
new=[]
auth=false
get "/" do
  slim :index
end

get "/auth" do
  if auth
    slim :index
  else
    slim :login
  end
end

get "/login" do
  auth=false
  slim :login
end 

post "/login" do
  if params['email']=="user" && params['password']=="password"
    auth=true
    slim :index
  else
    @msg="wrong credentials"
    slim :login
  end
end
get '/users' do
  users.map {|u| slim :userlist, {locals:u}}
end

get "/userform" do
  slim :adduser
end

post "/user" do
  n=params['name']
  e=params['uname']
  users.push(params[:user])
  p users
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

get "/group/form" do
  slim :addgroup
end

get "/search/form" do
  slim :search
end

post "/search" do
  p params['q']
end

delete "/fade_out_demo" do
  p ""
end

post "/validate/password" do
  p "nooo"
end
