module ApplicationHelper

  def send_mail(recipient_id, subject, type, space_id = nil, reservation_id = nil)
    @recipient = User.find(recipient_id)
    @space = Space.find_by_id(space_id)
    @reservation = Reservation.find_by_id(reservation_id)
    context = binding
    p "I'M SENDING AN EMAIL"
    erb type
    # p Pony.mail :headers => { 'Content-Type' => 'text/html' }, :from=>"admin@makersbnb.com", :to=> @recipient.email, :subject=> subject, :body=> erb(type, :layout => nil)
  end
end

# A user requests to book their space
# They confirm a request
# They request to book a space
# Their request to book a space is confirmed
# Their request to book a space is denied