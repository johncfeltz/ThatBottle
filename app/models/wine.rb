#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/wine.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Wine class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'wines'
#
#########################################################################################################

class Wine < ActiveRecord::Base

#  acts_as_ferret :fields => ['name', 'producer']  ferret Win86 install broken
  
  # Data model relationships

  belongs_to :appellation
  belongs_to :winecolor
  belongs_to :winetype
  has_many :tastingnotes, :as => :tasteable
  
  has_many :bottles
  has_and_belongs_to_many :warehouses

  # Max & min lengths for all fields
  NAME_MIN_LENGTH = 1
  NAME_MAX_LENGTH = 100
  PRODUCER_MAX_LENGTH = 80
  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  
  # Text box sizes for display in views
  NAME_SIZE = 80
  PRODUCER_SIZE = 60
  REFS_HORIZ_SIZE = 60
  REFS_VERT_SIZE = 5
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 10
  
  # Return order for generalize queries
  QUERY_RETURN_ORDER = "name, producer, appellation_id, id"

  # Validations
  
  validates_length_of     :name,       :within => NAME_RANGE
  validates_length_of     :producer,   :maximum => PRODUCER_MAX_LENGTH
  
  validates_presence_of   :appellation_id, :winecolor_id, :winetype_id

  # need to validate that wine name starts w/ a letter for alpha indexing.  How many out there are
  #  numeric or punctuation mark started?  Should I reject, convert, or ignore?


  # n-factor validations -- how to do these?? 
  # unique: name + producer + winecolor_id

  # Soft 'validations' - ie, catch mis-spellings, accent changes, abbreviations, etc.
  #  to provide warnings during create.
  
  # Text manipulations for convenience
  def namechain
    self.name + " " + self.appellation.namechain
  end
  
  def nameproducer
    if self.producer.nil?
      self.name
    else
      self.name + " (" + self.producer + ")"
    end
  end
  
  def namechain_long
    if self.producer.nil?
      self.namechain + " (" + self.winecolor.winecolor + " " + self.winetype.winetype + ")"
    else
      self.namechain + " " + self.producer + " (" + self.winecolor.winecolor + " " + self.winetype.winetype + ")"
    end
  end
  
# will_paginate method variables
  def self.per_page
    4   
  end
end
