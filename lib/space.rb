require 'sinatra/activerecord'

class Space < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence:true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user, presence: true


  def check_availability(month, year)
  day = 1
  results = []
  days_in_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  while day <= days_in_month[month] do
    date = Date.new(year, month, day)
    availability = Reservation.find_by(date: date, space_id: self.id)
    if availability.nil?
      availability = :available
    elsif availability.confirmed == false
      availability = :requested
    else
      availability = :booked
    end
    date_availability = {date: date, available: availability}
    results << date_availability
    day += 1
  end
    results
  end
end