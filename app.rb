require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative "config/application"

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'



get '/' do
  @posts = Post.all.order(created_at: :desc)
  erb :posts # Do not remove this line
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :show
end

post '/posts/:id' do
  post = Post.find(params[:id])
  post.votes += 1
  post.save
  redirect "/"
end

post '/posts' do
  new_post = Post.new(
    title: params[:title],
    url: params[:url]
  )
  new_post.user = User.all.sample
  new_post.save
  redirect '/'
end

delete "/posts/:id" do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/"
end
