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
    @spaces = Space.all
    erb :homepage, :layout => :layout
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
    erb :create_space, :layout => :layout
  end

  get '/spaces/:id' do
    @space = Space.find(params[:id])
    @availability = @space.check_availability
    erb :space, :layout => :layout
  end

  post '/add_space' do
    space = Space.new(name: params[:name], description: params[:description], price: params[:price], user_id: session[:user_id])
    if space.save
      flash[:success] = "Space created"
      redirect to '/'
    else
      redirect to '/spaces/new'
    end
  end

  get '/reservation-requests' do
    @requests = Reservation
    .joins(:space)
    .where(spaces: { user_id: session[:user_id]})
    .where('confirmed = false')
    erb :view_requests, :layout => :layout
  end

  post '/reservations' do
    reservation = Reservation.new(date: params[:date], user_id: session[:user_id], space_id: params[:space_id], confirmed: false)
    if reservation.save
      flash[:success] = "Request sent! The owner should respond shortly."
    else
      flash[:error] = "There was a problem sending your request."
    end
    redirect to "spaces/#{params[:space_id]}"
  end

  post '/reservations/:id/edit' do
    reservation = Reservation.find(params[:id])
    if params[:decision] == 'accept'
      reservation.update(confirmed: true)
      flash[:success] = "Reservation accepted"
    else
      reservation.destroy
      flash[:success] = "Reservation rejected"
    end
    redirect to '/reservation-requests'
  end

  # ONLY FOR TESTING UNTIL OTHER PAGES EXIST
  get '/data_setup' do
    user = User.create(username: 'Foo', email: "foo@example.com", password: "test")
    user2 = User.create(username: 'Bar', email: "bar@example.com", password: "test")
    Space.create(name: "Test Space", description: "A space for testing.", price: 10, user_id: user.id)
  end

  get '/test_reservation' do
    reservation = Reservation.create(date: Date.new(2020, 11, 11), user_id: session[:user_id], space_id: 1, confirmed: false)
  end

  run! if app_file == $0
end
