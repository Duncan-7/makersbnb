require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'

class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, "very secret"
  register Sinatra::Flash

  get '/' do
    "Hello World!"
  end



  run! if app_file == $0
end
