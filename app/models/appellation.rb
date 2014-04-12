#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/appellation.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Appellation class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'appellations'
#
#########################################################################################################

class Appellation < ActiveRecord::Base

  # Max & min lengths, and corresponding ranges, for all fields
  NAME_MIN_LENGTH = 1
  NAME_MAX_LENGTH = 60
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  
  #text box sizes for display in views
  NAME_SIZE = 40
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 8

  # Return order for generalize queries
  QUERY_RETURN_ORDER = "name, apptype_id, id"
  
  # Table length for pagination
  PAGINATION = 12
  
  # Data model relationships
  has_many :wines
  belongs_to :apptype
  acts_as_tree :foreign_key => "parentappellation_id", :order => QUERY_RETURN_ORDER

  # Validations
  
  validates_presence_of :name, :apptype_id
  
  validates_length_of   :name, :within => NAME_RANGE

  # 2-factor validations -- how to do these?? 
  # unique: name + apptype_id
  # apptype.country_id == parent_appellation.apptype.country_id
  # id != parentappellation_id
      
  # Text manipulations for convenience
  def namechain_naked
    if !self.apptype_id.nil?
      self.name + " - " + self.apptype.namechain_naked
    else
      self.name + " - ERROR_IN_APPTYPE"
    end    
  end
  
  def namechain
    "(" + self.namechain_naked + ")"
  end

# will_paginate method variables
  def self.per_page
    PAGINATION   
  end
end
