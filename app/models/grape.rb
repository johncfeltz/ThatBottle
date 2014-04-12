#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/grape.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Grape class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'grapes'
#
#########################################################################################################

class Grape < ActiveRecord::Base

  # Data model relationships
  
  # Max & min lengths for all fields
  NAME_MIN_LENGTH = 2
  NAME_MAX_LENGTH = 50

  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  
  #text box sizes for display in views and tables
  NAME_SIZE = 30
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 5
  
  NOTES_CLIP_LENGTH = 100
  
  # Return order for generalize queries
  QUERY_RETURN_ORDER = "name, id"
  
  # Validations
  
  validates_length_of     :name,          :within => NAME_RANGE

# will_paginate method variables
  def self.per_page
    20   
  end
  
end
