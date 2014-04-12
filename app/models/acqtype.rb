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
# Definition and extension for Acqtype class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'acqtypes'
#
#########################################################################################################
#
# This is enum data -- data model methods and admin-only CRUD pages 
#
#########################################################################################################

class Acqtype < ActiveRecord::Base

  has_many :acquisitions

  ACQTYPE_MIN_LENGTH = 1
  ACQTYPE_MAX_LENGTH = 20
  ACQTYPE_RANGE = ACQTYPE_MIN_LENGTH..ACQTYPE_MAX_LENGTH
  ACQTYPE_SIZE = 40
  
end
