#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/acquisition.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Acquisition class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'acquisitions'
#
#########################################################################################################

class Acquisition < ActiveRecord::Base

  # Max & min lengths, and corresponding ranges, for all fields
  
  #text box sizes for display in views

  # Return order for general queries
  
  # Table length for pagination
  PAGINATION = 12
  
  # Data model relationships
  has_many :bottles
  belongs_to :user
  belongs_to :acqtype

  # Validations
      
  # Text manipulations for convenience

# will_paginate method variables
  def self.per_page
    PAGINATION   
  end
end

