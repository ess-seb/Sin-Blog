require 'sinatra'
require 'sinatra/reloader' #gem sinatra-contrib
require 'pry'
require 'haml'
require 'data_mapper'
require 'dm-sqlite-adapter'

#skopiować binarki z http://www.sqlite.org/download.html do katalogu ruby200/bin
#może trzeba też do system32 i

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
	erb :view_newpost
end

post '/posts/create' do
        print params
		#binding.pry params

		# my_post = Post.new

		# my_post.attributes = params
		# my_post.save
        puts params[:body]
		Post.create(title: params[:title], body: params[:body])
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
