require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'haml'
require 'data_mapper'


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