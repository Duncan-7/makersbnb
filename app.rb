require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, "very secret"
  register Sinatra::Flash

  get '/' do
    "Hello World!"
  end

<<<<<<< HEAD

=======
  get '/signup' do
    erb :signup, :layout => :layout
  end

  get '/login' do
    erb :login, :layout => :layout
  end

  post '/users' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account created"
      redirect to '/'
    else
      flash[:error] = "Invalid details. Please try again."
      redirect to '/signup'
    end
  end

  post '/sessions' do
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/'
    else
      flash[:error] = "Invalid email or password"
      redirect to '/login'
    end
  end

  get '/logout' do
    session[:user_id] = nil
    redirect to '/login'
  end
>>>>>>> master

  run! if app_file == $0
end
