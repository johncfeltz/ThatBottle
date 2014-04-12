#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/warehousetype.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Warehousetype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'warehousetypes'
#
#########################################################################################################

class Warehousetype < ActiveRecord::Base

  has_many :warehouses

  WHTYPE_MIN_LENGTH = 1
  WHTYPE_MAX_LENGTH = 40
  WHTYPE_RANGE = WHTYPE_MIN_LENGTH..WHTYPE_MAX_LENGTH
  WHTYPE_SIZE = 40
  
end
