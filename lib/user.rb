require 'bcrypt'
require 'sinatra/activerecord'
require 'email_validator'

class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  has_many :spaces, dependent: :destroy
  has_many :reservations, dependent: :destroy
end