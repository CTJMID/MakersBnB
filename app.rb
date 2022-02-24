require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require './lib/user'
require './lib/database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    @spaces = Space.all
    @user_email = session[:user_email] 
    erb :'space'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/signup' do
    @user = session[:user]
    erb :'signup'
  end

  get '/sessions/new' do
    erb :'sessions/new'
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

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      session[:user_email] = user.email
      redirect '/spaces'
    else
      flash[:notice] = 'Please check your email or password'
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have logged out'
    redirect '/spaces'
  end

  run! if app_file == $0
end
