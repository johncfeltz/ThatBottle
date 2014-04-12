#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/winetype.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Winetype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'winetypes'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Winetype < ActiveRecord::Base
  
  has_many :wines

  WINETYPE_MIN_LENGTH = 1
  WINETYPE_MAX_LENGTH = 40
  WINETYPE_RANGE = WINETYPE_MIN_LENGTH..WINETYPE_MAX_LENGTH
  WINETYPE_SIZE = 40
  
end
