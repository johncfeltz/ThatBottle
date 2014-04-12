#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/profile.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Profile class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'profiles'
#
#########################################################################################################

class Profile < ActiveRecord::Base
  
  # Data model relationships
  belongs_to :user

end
