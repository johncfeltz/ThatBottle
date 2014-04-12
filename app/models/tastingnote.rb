#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/tastingnote.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Tastingnote class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'tastingnotes'
#
#########################################################################################################
#
# Tastingnote is the most important model/concept - the heart of the site, really - both technically 
# and in terms of the viability of ThatBottle.com.
#
# Techical:
# 1. It's polymorphic - either to wine or to bottle
#       1.1 If it's related to wine, we need to include vintage in the data model
#       1.2 If it's related to bottle, bottle.vintage overrides tastingnote.vintage
# 2. It's owned by a member
#       2.1 But other members can see it - paid members anytime, free members within 30 days of the 
#           create date
#       2.2 The member who owns it can always see it
#       2.3 The friendship model will make it even more complicated
# 
# Business:
# 3. The rating scales are crucial
#       3.1 A 100-point scale gives a false sense of precision
#       3.2 A 10-point scale might not give enough precision
#       3.3 The 20-point scale is unfamiliar to most laymen
#       3.4 Do people think linearly or logarithmically about this kind of thing?
#    WWID?  (What would IMDB do?)
#
#########################################################################################################

class Tastingnote < ActiveRecord::Base

# Data model relationships
  belongs_to :user
  belongs_to :tasteable, :polymorphic => true
 
  # Max & min lengths for all fields

  # Text box sizes for display in views
  VISUAL_HORIZ_SIZE = 60
  VISUAL_VERT_SIZE = 5
  OLFACTORY_HORIZ_SIZE = 60
  OLFACTORY_VERT_SIZE = 5
  GUSTATORY_HORIZ_SIZE = 60
  GUSTATORY_VERT_SIZE = 5

  NOTES_HORIZ_SIZE = 60
  NOTES_VERT_SIZE = 10
  
  # Return order for generalize queries
  QUERY_RETURN_ORDER = "created_at, id"

  # Number of days tasting notes are available for view by free members 
  FREE_MEMBER_HORIZON = 30
  
  # Validations

  # Text manipulations for convenience

end
