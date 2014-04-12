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
# Public-facing pages: standard boilerplate such as "About Us", "Legal/TOS", "Contact Us", etc.
# No RBA or other protection on these pages.
#
#########################################################################################################

class StaticController < ApplicationController
  include ApplicationHelper

  def index
    @title = "ThatBottle.com - The Community for Wine Lovers"
  end

  def about
    @title = "About ThatBottle"
  end

  def forbidden
    @title = "Unauthorized Access"
  end

  def help
    @title = "Help"
  end

  def devel
    @title = "News and Development Plans"
  end

  def legal
    @title = "Legal Notices"
  end

  def credit
    @title = "Credits and Thanks"
  end

  def contact
    @title = "Contact Us"
  end
end
