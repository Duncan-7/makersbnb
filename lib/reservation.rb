require 'sinatra/activerecord'

class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :user

  validates :user, presence: true
  validates :space, presence: true
end