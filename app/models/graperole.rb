#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/graperole.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Graperole class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'graperoles'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Graperole < ActiveRecord::Base
  
# has_many grape_appellations  # need to define join table for many-many relationship

  ROLE_MIN_LENGTH = 1
  ROLE_MAX_LENGTH = 20
  ROLE_RANGE = ROLE_MIN_LENGTH..ROLE_MAX_LENGTH
  WINETYPE_SIZE = 20
  
end
