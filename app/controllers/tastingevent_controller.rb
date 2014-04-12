#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/tastingevent_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Tasting Events
#
#########################################################################################################
#
# Not yet implemented
#
#########################################################################################################

class TastingeventController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
  def list
    @title = "List of Tastings"
  end

  def new
    @title = "Enter a New Tasting"
  end

  def show
    @title = "Tasting Details"
  end

  def edit
    @title = "Edit Tasting Details"
  end

end
