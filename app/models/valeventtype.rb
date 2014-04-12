#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/valeventtype.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Valeventtype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'valeventtypes'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Valeventtype < ActiveRecord::Base
  
#  has_many :valuationevents ???

  EVENTTYPE_MIN_LENGTH = 1
  EVENTTYPE_MAX_LENGTH = 20
  EVENTTYPE_RANGE = EVENTTYPE_MIN_LENGTH..EVENTTYPE_MAX_LENGTH
  EVENTTYPE_SIZE = 20
  
end
