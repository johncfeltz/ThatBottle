#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/userstatus.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Userstatus class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'userstatuses'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Userstatus < ActiveRecord::Base

  has_many :users

  STATUS_MIN_LENGTH = 1
  STATUS_MAX_LENGTH = 20
  STATUS_RANGE = STATUS_MIN_LENGTH..STATUS_MAX_LENGTH
  STATUS_SIZE = 40
  
end
