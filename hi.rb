require 'sinatra'
require 'sinatra/reloader' #gem sinatra-contrib
require 'pry'
require 'haml'
require 'data_mapper'
require 'dm-sqlite-adapter'

require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

#skopiować binarki z http://www.sqlite.org/download.html do katalogu ruby200/bin
#może trzeba też do system32 i

#set :haml, :format => :html5
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
		redirect "/posts"
end

# update
get '/posts/edit/:id' do
	@post = Post.get(params[:id])
	erb :edit_post
end


post '/posts/update/:id' do
	to_edit = Post.get(params[:id])
	to_edit.update(params[:post])
	redirect '/posts'
end


get '/posts/destroy/:id' do
	to_destroy = Post.get(params[:id])
	to_destroy.destroy
	redirect '/posts'
end


# list this shit
get '/posts' do
	@post_list = Post.all
	erb :posts_list
end

not_found do
  halt 404, 'page not found'
end
