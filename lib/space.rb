require 'sinatra/activerecord'

class Space < ActiveRecord::Base
    belongs_to :user

    def check_availability(id)
    day = 1
    month = []
    while day < 31 do
      date = Date.new(2020, 11, day)
      availability = Reservation.find_by(date: date, space_id: id)
      if availability.nil?
        availability = :available
      elsif availability.confirmed == false
        availability = :requested
      else
        availability = :booked
      end
      date_availability = {date: date, available: availability}
      month << date_availability
      day += 1
    end
      p month
      month
    end
end