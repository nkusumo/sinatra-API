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

  get "/groups/:id/winner" do
    winner = Group.find(params[:id]).winner
    if winner
      Movie.find(winner).to_json
    else
      empty = {}
      empty.to_json
    end
  end

  post "/votes" do
    puts params.inspect
    vote_params = params.select do |key|
      ["first", "second", "third", "user_id", "group_id"].include?(key)
    end
    user_group = UserGroup.find_by(user_id: vote_params["user_id"], group_id: vote_params["group_id"])
    vote_array = []
    vote_array << Vote.create(user_group_id: user_group.id, movie_id: vote_params["first"], rank: 1)
    vote_array << Vote.create(user_group_id: user_group.id, movie_id: vote_params["second"], rank: 2)
    vote_array << Vote.create(user_group_id: user_group.id, movie_id: vote_params["third"], rank: 3)
    vote_array.to_json
  end

  get "/winner/:group_id" do
    Group.find(params[:group_id]).winning_movie.to_json
  end

  post "/new-group" do
    puts params.inspect
    group_params = params.select do |key|
      ["name", "members", "movies"].include?(key)
    end
    Group.create(group_name: group_params["name"])
    group_id = Group.last.id

    group_params["members"].each {|id| UserGroup.create(user_id: id, group_id: group_id)}
    movieIDs = []
    group_params["movies"].each do |movie|
      Movie.create(title: movie[:title], genre: movie[:genre], release_date: movie[:release_date], image: movie[:image], rating: movie[:rating])
      movieIDs << Movie.last.id
    end

    movieIDs.each {|id| GroupMovie.create(movie_id: id, group_id: group_id)}

    "Success!".to_json
  end

  post "/new-user" do
    puts params.inspect
    user_param = params.select {|key| ["name"].include?(key)}
    User.create(name: user_param["name"])
    User.last.to_json
  end

end
