#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/grape_controller.rb
# Version:  Beta 2
# Date:     10 July 2008
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
# DEPRECATED
#
# This file is saved as an example for learning/historical purposes only.
#
# saved as of 10 July 2008 11:00 AM 
# need to tweak edit/update method to DRY it up. 
# need to tweak edit.html.erb page as well. 
#
# 10 July 2008 13:00 
# work completed in main branch of source code -- keep this for example only
#
#########################################################################################################

class GrapeController < ApplicationController

  def index    # from RailsSpace chapter 10
    @title = "Wine Grapes"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    @initial = !params[:id].nil? ? params[:id] : "A"
    @grapes = Grape.paginate(:conditions => ["name like ?", @initial+'%'],
                             :page => params[:page], :order => Grape::QUERY_RETURN_ORDER)  
  end

  def list
    @title = "Wine Grapes"
    @grapes = Grape.find(:all, :order => Grape::QUERY_RETURN_ORDER)  
  end

  def new
    @title = "Enter a New Wine Grape"
    if request.post? and params[:grape]
      @grape = Grape.new(params[:grape])
      if @grape.save
        flash[:notice] = "#{@grape.name} saved"
        redirect_to :action => "index"
      end
    end  
  end

  def show
    @title = "Wine Grape Details"
    @grape = Grape.find(params[:id])
  end

#  def edit
#    @grape = Grape.find(params[:id])
#    @title = "Edit Grape: #{@grape.name}"
#    if param_posted?(:grape)
#      if @grape.update_attributes(params[:grape])
#        flash[:notice] = "#{@grape.name} (#{@grape.id}) updated"
#        redirect_to :action => "index"
#      end
#    end    
#  end

  def edit
    @grape = Grape.find(params[:id])
  end

  def update
    @grape = Grape.find(params[:id])
    if @grape.update_attributes(params[:grape])
      flash[:notice] = "#{@grape.name} (#{@grape.id}) updated"
      redirect_to :action => "index"
    end
  end
  
  def search
    @title = "Search Grapes"
    if params[:q]
      query = params[:q]
      @grapes = Grape.paginate(:conditions => ["UPPER(name) like UPPER(?)", '%'+query+'%'], 
                               :page => params[:page], :order => Grape::QUERY_RETURN_ORDER)
    end
  end
end
