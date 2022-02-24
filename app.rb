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
    result = Conn.query("SELECT * FROM users WHERE email = $1",[params[:email]])
    user = User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password'])
    session[:user_id] = user.id
    redirect '/spaces'
  end


  run! if app_file == $0
end
