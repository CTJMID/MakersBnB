require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    'List of spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    redirect '/spaces'
  end

  run! if app_file == $0
end