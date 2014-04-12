#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/apptype.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Apptype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'apptypes'
#
#########################################################################################################

class Apptype < ActiveRecord::Base

  # Data model relationships
  has_many :appellations
  belongs_to :country
  acts_as_tree :foreign_key => "nexthigher_id"

  # Max & min lengths for all fields
  ABBREV_MIN_LENGTH = 1
  ABBREV_MAX_LENGTH = 10
  FULLNAME_MIN_LENGTH = 1
  FULLNAME_MAX_LENGTH = 80
  TRANSLATION_MAX_LENGTH = 80
  
  ABBREV_RANGE = ABBREV_MIN_LENGTH..ABBREV_MAX_LENGTH
  FULLNAME_RANGE = FULLNAME_MIN_LENGTH..FULLNAME_MAX_LENGTH
  
  #text box sizes for display in views
  ABBREV_SIZE = 10
  FULLNAME_SIZE = 40
  TRANSLATION_SIZE = 40
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 8

  # Return order for generalize queries
  QUERY_RETURN_ORDER = "abbrev, country_id, id"
  
  # Validations
  
  validates_presence_of :country_id, :abbrev, :fullname
  
  validates_length_of   :abbrev,      :within => ABBREV_RANGE
  validates_length_of   :fullname,    :within => FULLNAME_RANGE
  validates_length_of   :translation, :maximum => TRANSLATION_MAX_LENGTH
  
  # 2-factor validations -- how to do these?? 
  # unique: abbrev + country
  # unique: fullname + country
  # country_id == nexthigher.country_id
  # id != nexthigher_id
  
  # Text manipulations for convenience
  def namechain_naked
    if !self.country_id.nil?
      self.abbrev + " - " + self.country.name
    else
      self.abbrev + " - ERROR_IN_COUNTRY"
    end
  end
  
  def namechain
    "(" + self.namechain_naked + ")"
  end
      
# will_paginate method variables
  def self.per_page
    10   
  end  
end
