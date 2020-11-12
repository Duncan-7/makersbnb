module ApplicationHelper

  def send_mail(recipient_id, subject, type)
    @recipient = User.find(recipient_id)
    context = binding
    Pony.mail :headers => { 'Content-Type' => 'text/html' }, :from=>"jackliammorris@gmail.co.uk", :to=> 'jack3009@hotmail.co.uk', :subject=> subject, :body=> erb(type, :layout => nil)
  end
end