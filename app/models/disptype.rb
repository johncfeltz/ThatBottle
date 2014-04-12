#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/acqtype.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Disptype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'disptypes'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Disptype < ActiveRecord::Base
  
  has_many :bottles

  DISPTYPE_MIN_LENGTH = 1
  DISPTYPE_MAX_LENGTH = 20
  DISPTYPE_RANGE = DISPTYPE_MIN_LENGTH..DISPTYPE_MAX_LENGTH
  DISPTYPE_SIZE = 40
  
end
