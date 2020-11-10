require 'bcrypt'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_secure_password

  has_many :spaces, dependent: :destroy
end