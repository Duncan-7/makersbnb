require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './lib/user'
require './lib/space'
require './lib/reservation'


class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, "very secret"
  register Sinatra::Flash

  get '/' do
    "Hello World!"
  end

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

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :user_profile, :layout => :layout
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    erb :update_user, :layout => :layout
  end

  post '/users/:id' do
    user = User.find(params[:id])
    if user && user.id == session[:user_id] && user.authenticate(params[:password])
      user.update(username: params[:username], email: params[:email])
      flash[:success] = "Account updated"
      redirect to "/users/#{params[:id]}"
    else
      flash[:error] = "Update failed"
      redirect to "/users/#{params[:id]}/edit"
    end
  end

  get '/users/:id/delete' do
    if params[:id].to_i == session[:user_id]
      user = User.find(params[:id])
      user.destroy
      flash[:success] = "Account deleted"
      redirect to '/signup'
    else
      flash[:error] = "Error occurred"
      redirect to '/users/' + params[:id]
    end
  end


  get '/spaces/new' do
    erb :index
  end

  post '/add_space' do
    space = Space.new(name: params[:name], description: params[:description], price: params[:price], user_id: session[:user_id])
    if space.save
      flash[:success] = "Space created"
      redirect to '/login'
    else
      redirect to '/spaces/new'
    end
  end
  run! if app_file == $0
end
