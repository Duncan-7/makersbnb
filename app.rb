require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './lib/user'
require './lib/space'
require './lib/reservation'
require 'pony'
require './helpers'


class MakersBnb < Sinatra::Base
  helpers ApplicationHelper
  enable :sessions
  set :session_secret, "very secret"
  register Sinatra::Flash

  get '/' do
    @spaces = Space.all
    erb :homepage, :layout => :layout
  end

  get '/signup' do
    @attempted_username = session[:username]
    @attempted_email = session[:email]
    session[:username] = nil
    session[:email] = nil
    erb :signup, :layout => :layout
  end

  get '/login' do
    @attempted_email = session[:email]
    session[:email] = nil
    erb :login, :layout => :layout
  end

  post '/users' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account created"
      send_mail(user.id, 'Welcome!', :mail_signup)
      redirect to '/'
    else
      session[:username] = params[:username]
      session[:email] = params[:email]
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
      session[:email] = params[:email]
      flash[:error] = "Invalid email or password"
      redirect to '/login'
    end
  end

  get '/spaces' do
    erb :spaces
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
    @attempted_name = session[:name]
    @attempted_description = session[:description]
    @attempted_price = session[:price]
    session[:name] = nil
    session[:description] = nil
    session[:price] = nil
    erb :create_space, :layout => :layout
  end

  get '/spaces/:id' do
    @reservations = Reservation.where(user_id: session[:user_id], space_id: params[:id])
    @space = Space.find(params[:id])
    if params[:month].nil?  
      @date = Date.today
    else
      @date = Date.new(params[:year].to_i, params[:month].to_i)
    end
    @availability = @space.check_availability(@date.month, @date.year)
    erb :space, :layout => :layout
  end

  get '/space/:id/edit' do
    @space = Space.find(params[:id])
    erb :update_space, :layout => :layout
  end

  post '/space/:id/edit' do
    space_to_update = Space.find(params[:id])
    space_to_update.name = params[:name]
    space_to_update.price = params[:price]
    space_to_update.description = params[:description]
    if space_to_update.save
      flash[:success] = "Space updated"
      send_mail(space_to_update.user.id, 'Space Updated', :mail_update_space, space_to_update.id)
      redirect '/'
    else
      flash[:error] = "There was a problem updating this space"
      redirect back
    end
  end

  get '/space/:id/delete' do
    space = Space.find(params[:id])
    space.destroy
    flash[:success] = 'Space deleted'
    redirect '/'
  end

  post '/add_space' do
    space = Space.new(name: params[:name], description: params[:description], price: params[:price], user_id: session[:user_id])
    if space.save
      flash[:success] = "Space created"
      send_mail(space.user.id, 'New Space Created', :mail_create_space, space.id)
      redirect to '/'
    else
      session[:name] = params[:name]
      session[:description] = params[:description]
      session[:price] = params[:price]
      flash[:error] = "Problem creating space"
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

  get '/reservations' do
    @my_spaces = Reservation
    .joins(:space)
    .where(spaces: { user_id: session[:user_id]})
    .where('confirmed = true')
    @my_trips = Reservation.where(user_id: session[:user_id])
    p @my_trips
    erb :reservations, :layout => :layout
  end

  post '/reservations' do
    reservation = Reservation.new(date: params[:date], user_id: session[:user_id], space_id: params[:space_id], confirmed: false)
    if reservation.save
      flash[:success] = "Request sent! The owner should respond shortly."
      send_mail(reservation.space.user.id, 'New Reservation Request', :mail_request_received, reservation.space.id, reservation.id)
      send_mail(reservation.user.id, 'Reservation Requested', :mail_request_sent, reservation.space.id, reservation.id)
    else
      flash[:error] = "There was a problem sending your request."
    end
    redirect back
  end

  post '/reservations/:id/edit' do
    reservation = Reservation.find(params[:id])
    if params[:decision] == 'accept'
      reservation.update(confirmed: true)
      Reservation.where(date: reservation.date, confirmed: false).destroy_all
      flash[:success] = "Reservation accepted"
      send_mail(reservation.space.user.id, "Booking confirmed", :mail_confirm_request, reservation.space.id, reservation.id)
      send_mail(reservation.user.id, "Booking confirmed", :mail_request_confirmed, reservation.space.id, reservation.id)
    else
      send_mail(reservation.user.id, "Booking rejected", :mail_request_denied, reservation.space.id, reservation.id)
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

  get '/test_email' do
    send_mail(1, 'test mail', :mail_signup)
    # Pony.mail :from=>"admin@makersbnb.com", :to=> "duncanmorrison2001@yahoo.com", :subject=> "test subject", :body=> "testing"
  end

  run! if app_file == $0
end
