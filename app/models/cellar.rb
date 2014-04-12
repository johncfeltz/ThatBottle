#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/cellar.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Cellar class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'cellars'
#
#########################################################################################################

class Cellar < ActiveRecord::Base

# Data model relationships
  has_many   :bottles
  belongs_to :user
  
# Validations

# Text manipulations for convenience

end
