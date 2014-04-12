#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/grape_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on wine-making Grapes
#
#########################################################################################################
#
# Major accomplishment on 10 July 2008 12:43 -- edit controller & view working & DRY
#   The key is to include :url => {:id => @grape} in the form_for tag of view.html.erb
# 
# This file serves as the example for other controllers' edit actions
#
#########################################################################################################

class GrapeController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
# alphabetical index from RailsSpace chapter 10 + pagination
  def index    
    @title = "Wine Grapes"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    @initial = !params[:id].nil? ? params[:id] : "A"
    @grapes = Grape.paginate(:conditions => ["name like ?", @initial+'%'],
                             :page => params[:page], :order => Grape::QUERY_RETURN_ORDER)  
  end

# complete list of grapes.  Overload standard pagination eventually when list gets too long.
  def list    
    @title = "List of Wine Grapes"
    @grapes = Grape.find(:all, :order => Grape::QUERY_RETURN_ORDER)  
  end

  def new
    @title = "Enter a New Grape"
    if param_posted?(:grape)
      @grape = Grape.new(params[:grape])
      if @grape.save
        flash[:notice] = "#{@grape.name} saved"
        redirect_to :action => "index"
      end
    end  
  end

  def show    
    @grape = Grape.find(params[:id])
    @title = "Grape Details: #{@grape.name}"
  end

  def edit
    @grape = Grape.find(params[:id])
    @title = "Edit Grape: #{@grape.name}"
    if param_posted?(:grape)
      if @grape.update_attributes(params[:grape])
        flash[:notice] = "#{@grape.name} (#{@grape.id}) updated"
        redirect_to :action => "index"
      end
    end    
  end

# currently search by name only: will incorporate notes via Ferret in the future.
# use MySQL UPPER() function on DB column and on query string to make case insensitive. 
  def search    
    @title = "Search Grapes"
    if params[:q]
      query = params[:q]
      @grapes = Grape.paginate(:conditions => ["UPPER(name) like UPPER(?)", '%'+query+'%'], 
                               :page => params[:page], :order => Grape::QUERY_RETURN_ORDER)
    end
  end
end
