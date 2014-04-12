#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/winecolor.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Winecolor class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'winecolors'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Winecolor < ActiveRecord::Base
  
  has_many :wines

  WINECOLOR_MIN_LENGTH = 1
  WINECOLOR_MAX_LENGTH = 40
  WINECOLOR_RANGE = WINECOLOR_MIN_LENGTH..WINECOLOR_MAX_LENGTH
  WINECOLOR_SIZE = 40
  
end
