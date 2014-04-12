#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/country.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Country class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'countries'
#
#########################################################################################################

class Country < ActiveRecord::Base

  # Data model relationships
  has_many :apptypes
  
  # Max & min lengths for all fields
  NAME_MIN_LENGTH = 4
  NAME_MAX_LENGTH = 30
  ISOCODE_NUM_LENGTH = 3
  ISOCODE_2LET_LENGTH = 2
  ISOCODE_3LET_LENGTH = 3
  
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  
  #text box sizes for display in views
  NAME_SIZE = 30
  ISOCODE_NUM_SIZE = 3
  ISOCODE_2LET_SIZE = 2
  ISOCODE_3LET_SIZE = 3
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 15
  
  # Return order for generalize queries
  QUERY_RETURN_ORDER = "name, id"
  
  # Validations
  
  validates_uniqueness_of :name, :isocode_num, :isocode_2let, :isocode_3let
  
  validates_length_of     :name,          :within => NAME_RANGE
  validates_length_of     :isocode_2let,  :is     => ISOCODE_2LET_LENGTH
  validates_length_of     :isocode_3let,  :is     => ISOCODE_3LET_LENGTH
  validates_length_of     :isocode_num,   :is     => ISOCODE_NUM_LENGTH
  
  validates_format_of     :isocode_num,
                          :with => /^\d+$/
  
  validates_format_of     :isocode_2let,
                          :with => /^[A-Z]+$/
                          
  validates_format_of     :isocode_3let,
                          :with => /^[A-Z]+$/

  # will_paginate method variables
  def self.per_page
    10    
  end
end
