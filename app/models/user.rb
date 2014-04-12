#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/user.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for User class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'users'
#
#########################################################################################################

require 'digest/sha2'             # for hashing passwords, session IDs, etc.

class User < ActiveRecord::Base
  
# Data model relationships
  has_one :cellar
  has_one :warehouse
  belongs_to :userstatus
  has_one :profile
  has_many :tastingnotes
  
# Max & min lengths for all fields
  HANDLE_MIN_LENGTH = 4
  HANDLE_MAX_LENGTH = 40
  FULLNAME_MIN_LENGTH = 4
  FULLNAME_MAX_LENGTH = 60  
  EMAIL_MAX_LENGTH = 50
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40
  START_YEAR = 1880
  
  HANDLE_RANGE = HANDLE_MIN_LENGTH..HANDLE_MAX_LENGTH
  FULLNAME_RANGE = FULLNAME_MIN_LENGTH..FULLNAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  #text box sizes for display in views
  HANDLE_SIZE = 40
  FULLNAME_SIZE = 40
  PASSWORD_SIZE = 40
  EMAIL_SIZE = 50

# Starting User Number - allows low numbers to be reserved for admins, test, friends & family,
# etc.  Do this?  How to enforce in MySQL?
#  MIN_USER_NUMBER = 1001
#
# 'magic super-secret' id for the admin user is 327
#

  #validations
  
  validates_length_of     :handle,     :within => HANDLE_RANGE
  validates_length_of     :fullname,   :within => FULLNAME_RANGE
  validates_length_of     :email,      :maximum => EMAIL_MAX_LENGTH
  validates_length_of     :password,   :within => PASSWORD_RANGE
  
  validates_uniqueness_of :handle, :email
  validates_presence_of   :fullname
  
  validates_format_of     :handle,
                          :with => /^[A-Z0-9_]*$/i,
                          :message => "must contain only letters, " +
                                      "numbers, and underscores"

  validates_format_of     :email,
                          :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                          :message => "must be a valid email address"

  def validate
    min_dob = Date.new(Date.today.year - 21, Date.today.mon, Date.today.day)
    errors.add(:dob, "You must be at least 21 years old.") unless dob <= min_dob
  end
  
# functions for login and RBA

  attr_accessor :remember_me

  def login!(session)
    session[:user_id] = id    
  end
  
  # admin = 1, pro = 2, full = 3, free = 4
  # there's got to be a better way to do this - by inspection or search or something.
  def setstatus!(status)
    if status == "admin"
      self.userstatus_id = 1
    elsif status == "pro"
      self.userstatus_id = 2
    elsif status == "full"
      self.userstatus_id = 3
    else
      self.userstatus_id = 4
    end
  end
  
  def self.logout!(session, cookies)
    session[:user_id] = nil
    cookies.delete(:authorization_token)
  end

  def remember!(cookies)
    cookie_expiration = 10.years.from_now
    cookies[:remember_me] = { :value => "1", :expires => cookie_expiration }
    self.authorization_token = unique_identifier
    save!
    cookies[:authorization_token] = { :value => authorization_token,
                                      :expires => cookie_expiration } 
  end

  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end
  
  def remember_me?
    remember_me == "1"
  end
  
  # Clear the password - typically to suppress display in a view
  def clear_password!
    self.password = nil
  end
  
  private
  
  # Generate a unique identifier for a user
  def unique_identifier
    Digest::SHA2.hexdigest("#{handle}:#{password}")
  end
end

