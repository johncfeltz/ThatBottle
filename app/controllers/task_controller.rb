#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/task_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Common tasks and task sequences for members.  Each task involves hitting a number of CRUD operations
#   for the various higher-level objects.  Examples: 
#   1.  Create a tasting event, invite friends to the event, associate bottles with the event, 
#       and then record tasting notes for each bottle.
#   2.  Record a purchase of wine by automatically pre-filling fields in the wine/new form, and looping
#       through that view until the entire purchase has been recorded, then present summary information
#       on total cost, average bottle price, etc.
#
#########################################################################################################
#
# Not yet implemented
#
#########################################################################################################

class TaskController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
  def acquire
    # set up a new acquisition object
    # loop through the new bottle process 1->N times
  end

  def dispose
    # find bottle and modify bottle object.
    # set up 'public bottle' table so my bottle can have tasting notes from other people.  many-many join.
    # loop?
  end

  def taste
    # loop:
    #   find wines
    #   create tasting objects
  end

end
