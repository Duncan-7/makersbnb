module ApplicationHelper

  def send_mail(recipient_id, subject, type, space_id = nil, reservation_id = nil)
    @recipient = User.find(recipient_id)
    @space = Space.find_by_id(space_id)
    @reservation = Reservation.find_by_id(reservation_id)
    context = binding
    p "I'M SENDING AN EMAIL"
    # p Pony.mail :headers => { 'Content-Type' => 'text/html' }, :from=>"noreply@makersbnb.com", :to=> @recipient.email, :subject=> subject, :body=> erb(type, :layout => nil)
  end
end