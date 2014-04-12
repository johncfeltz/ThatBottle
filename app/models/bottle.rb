#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/bottle.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Bottle class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'bottles'
#
#########################################################################################################

class Bottle < ActiveRecord::Base

  # Data model relationships
  belongs_to :wine
  belongs_to :cellar
  belongs_to :disptype
  belongs_to :acquisition
  has_many :tastingnotes, :as => :tasteable
  
  # Max & min lengths for all fields
  VINTAGE_MAX_LENGTH = 6
  BOTTLESIZE_MAX_LENGTH = 8
  ALCOHOL_MAX_LENGTH = 5
  CELLARLABEL_MAX_LENGTH = 20
  CELLARLOCATION_MAX_LENGTH = 50

  # Text box sizes for display in views
  
  VINTAGE_SIZE = 4
  BOTTLESIZE_SIZE = 8
  ALCOHOL_SIZE = 4
  CELLARLABEL_SIZE = 20
  CELLARLOCATION_SIZE = 50
  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 10
  
  # Validations
  
  validates_presence_of     :wine_id, :cellar_id
  ##  validates_numericality_of :vintage, :only_integer => true    # unless it's nil, of course.  how to do??
  validates_numericality_of :bottlesize, :alcohol
  
  # Text manipulations for convenience
  
  def instock?
    if self.disptype_id == 0
      true
    else
      false
    end
  end
  
  def namechain
    if !self.vintage.nil?
      self.wine.namechain
    else
      self.wine.namechain + " " + vintage
    end
  end
  
  def numnamechain
    self.cellarnum.to_s + ": " + self.namechain
  end
  
  def ownerchain
    "#{self.cellar.user.handle}'s bottle ##{self.cellarnum}"
  end
  
end
