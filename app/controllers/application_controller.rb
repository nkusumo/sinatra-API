require 'pry'

class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,PATCH,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  # method "URL" do
    
  # end
  get "/movies" do
    Movie.all.to_json
  end

  get "/users" do
    User.all.to_json
  end

  get "/users/:id" do
    user = User.find(params[:id])
    user.to_json
  end

  get "/users/:id/groups" do
    User.find(params[:id]).groups.to_json
  end

  get "/groups/:id/movies" do
    Group.find(params[:id]).movies.to_json
  end
  
  get "/groups/:id/users" do
    Group.find(params[:id]).users.to_json
  end

  post "/votes" do
    puts params.inspect
    vote_params = params.select do |key|
      ["first", "second", "third", "user_id", "group_id"].include?(key)
    end
    user_group = UserGroup.find_by(user_id: params[user_id], group_id: params[group_id])
    puts user_group.user_id
  end
  #WE NEED TO FIX THIS

end
