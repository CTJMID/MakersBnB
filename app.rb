require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require './lib/user'
require './lib/booking'
require './lib/database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get '/' do
    redirect '/spaces'
  end

  get '/spaces' do
    @user_email = session[:user_email] 
    @date_order_error = false
    @show_button = false

    if params.key?('available_from')
      @available_from = params['available_from']
      @available_to = params['available_to']

      if @available_from > @available_to
        @spaces = Space.all
        @date_order_error = true
      else
        @spaces = Space.selection(@available_from, @available_to)
        @show_button = true
      end

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
  
  get '/confirmation' do
    erb :'confirmation'
  end

  post '/spaces/book' do
    @title = params['title']
    @price = params['price']
    @description = params['description']
    @booked_dates = Booking.space_dates_not_available(params['id'])
    erb :'spaces/book'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/spaces' do
    Space.create(params['title'], params['description'], params['price'])
    redirect '/spaces'
  end

  post '/book' do
    Space.book(params['available_from'], params['available_to'], params['id'])
    redirect '/book'
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

  get '/test' do
    @user_email = session[:user_email] 
    erb :'test'
  end

  run! if app_file == $0
end
