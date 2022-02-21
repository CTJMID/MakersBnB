require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'space'
  end

  run! if app_file == $0
end
