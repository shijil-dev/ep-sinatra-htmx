require 'sinatra'
require 'slim'
require 'yaml'
require 'json'
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

get "/userform" do
  slim :adduser
end
get "/user/layout" do
  slim :userlistlayout
end
get '/users' do
  #users.map {|u| slim :userlist, {locals:u}}
  users_json=File.read("users.json")
  users=JSON.parse(users_json)
  users.map {|user|slim :userlist,{locals:user}}
end

post "/user" do
  #File.open("users.yml","w") { |file| file.write params[:user].to_yaml }
  uarr=JSON.parse(File.read("users.json"))
  uarr << params[:user]
  File.write("users.json",JSON.pretty_generate(uarr))
end

post "/useropt" do
  uname=params['uname']
  users=JSON.parse(File.read("users.json"))
  user=users.find {|u| u["uname"]==uname}
  if user
    slim :useropt,{locals:user}
  else
    p "user does not exist"
  end
end

post "/useredit" do
  user=params['user']
  slim :useredit ,{locals:user}
end

get "/group/form" do
  slim :addgroup
end

get "/search/form" do
  slim :search
end

post "/search" do
  users=JSON.parse(File.read("users.json"))
  selected_users = params['q'] ? (users.select{|u| u["uname"] =~ /#{Regexp.quote(params['q'])}/i}) : []
  p selected_users
  selected_users.map {|user| slim :userlist,{locals:user} }
end

delete "/fade_out_demo" do
  p ""
end

