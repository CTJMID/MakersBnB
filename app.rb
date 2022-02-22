require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require './lib/user'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'space'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/signup' do
    @user = session[:user]
    erb :'signup'
  end

  post '/spaces' do
    Space.create(title: params['title'])
    redirect '/spaces'
  end

  post '/signup' do
    session[:user] = User.create(email: params['email'], password: params['password'])
    redirect '/signup'
  end

  run! if app_file == $0
end
