require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require './lib/user'
require './lib/database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    if params.key?('available_from')
      @spaces = Space.selection(params['available_from'], params['available_to'])
    else
      @spaces = Space.all
    end

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
    Space.create(params['title'], params['description'], params['price'])
    redirect '/spaces'
  end

  post '/book' do
    Space.book(params['id'])
    redirect '/spaces'
  end

  post '/signup' do
    if User.unique?(email: params['email'])
      session[:user] = User.create(email: params['email'], password: params['password'])
    else
      session[:user] = false
    end
  
    redirect '/signup'
  end

  run! if app_file == $0
end
