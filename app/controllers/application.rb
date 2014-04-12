#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/application.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Global controller provided by Rails.
#
#########################################################################################################
#
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery  :secret => '3e60abf1396cffa068fc8d3dfc218416'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
#  
#  Return true if a parameter corresponding to the given symbol was posted
#  Courtesy of RailsSpace book.
#
  def param_posted?(sym)
    request.post? and params[sym]
  end

end
