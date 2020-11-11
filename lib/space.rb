require 'sinatra/activerecord'

class Space < ActiveRecord::Base
    belongs_to :user
    has_many :reservations, dependent: :destroy

    validates :name, presence: true, length: { maximum: 80 }
    validates :description, length: { maximum: 500 }
    validates :price, numericality: { only_integer: true, greater_than: 0 }
    validates :user, presence: true


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
      month
    end
end