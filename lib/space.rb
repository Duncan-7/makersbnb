require 'sinatra/activerecord'

class Space < ActiveRecord::Base
    belongs_to :user


end