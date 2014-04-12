#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/admin_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Administrative control: user maintenance, reports, special beta test operations, 
#   and database manipulations.
#
#########################################################################################################

class AdminController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_if_forbidden
  

  def index
    @title = "ThatBottle Administrator Zone"
  end

end
