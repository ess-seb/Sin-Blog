require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'haml'
require 'data_mapper'
require 'dm-sqlite-adapter'

# get '/hi' do
#   "Hello World!"
# end

# get '/yo/:name' do
# 	yo = params[:name]
#   # matches "GET /hello/foo" and "GET /hello/bar"
#   # params[:name] is 'foo' or 'bar'
#   @napis = "Hello #{yo}!"
# end



#set :haml, :format => :html5



get '/viewhaml' do
  @items = ["yo", "jo"]
	#binding.pry
  haml :viewhaml, :locals => {:items => @items}
end

get '/viewerb' do
	@items = ["yo", "jo"]
  erb :viewerb, :locals => {:items => @items}
end

get '/posts/new' do 
	erb :view_newpost, lay
end

post '/posts/create' do 
		# binding.pry params
	
		# my_post = Post.new

		# my_post.attributes = params
		# my_post.save
		Post.create(:title => params[:title], :body => params[:content])
end

get '/posts' do
		@post_list = Post.all
		erb :posts_list 
end



require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :body, Text
    property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!