#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/appellation_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Appellations (i.e., named wine regions)
#
#########################################################################################################

class AppellationController < ApplicationController
  include ApplicationHelper

  before_filter :redirect_if_forbidden
    
  def index      # from RailsSpace chapter 10
    @title = "Appellations"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    @initial = !params[:id].nil? ? params[:id] : "A"
    @appellations = Appellation.paginate(:conditions => ["name like ?", @initial+'%'], 
                                         :page => params[:page], :order => Appellation::QUERY_RETURN_ORDER)
  end
  
  def list
    @appellations = Appellation.find(:all, :order => Appellation::QUERY_RETURN_ORDER)
    @title = "List of Appellations"
  end

# experimental sortable table: automagically re-sorts when click on column header.
  def sortlist
    if params[:sortcolumn].nil?
      order = Appellation::QUERY_RETURN_ORDER
    else
      order = params[:sortcolumn] + ", " + Appellation::QUERY_RETURN_ORDER       
    end
    @appellations = Appellation.paginate(:all, :page => params[:page], :order => order)
    @title = "List of Appellations"    
  end
  
  def new
    @title = "Enter a New Appellation"
    # arrays to pass in for select statements.  NIL first entry for appellations because not every 
    #   one has a parent
    @appellations  = [[nil,"(none)"]] + Appellation.find(:all, :order => "name").map {|a| [a.namechain_naked, a.id]}
    @apptypes = Apptype.find(:all, :order => "abbrev").map {|apt| [apt.namechain_naked, apt.id]}
    
    if param_posted?(:appellation)
      @appellation = Appellation.new(params[:appellation])
      if @appellation.save
        flash[:notice] = "#{@appellation.namechain_naked} saved"
        redirect_to :action => "index"
      end
    end
  end

  def show
    @appellation = Appellation.find(params[:id])
    @title = "Appellation Details: #{@appellation.name}"
    @wines = Wine.find(:all, 
         :conditions => ["appellation_id = ?", params[:id]],
         :order => "name, producer, winecolor_id") 
  end

  def edit
    @appellation = Appellation.find(params[:id])
    @title = "Edit Appellation: #{@appellation.namechain_naked}"
    # arrays to pass in for select statements.  NIL first entry for appellations because not every 
    #   one has a parent
    @appellations  = [[nil,"(none)"]] + Appellation.find(:all, :order => "name").map {|a| [a.namechain_naked, a.id]}
    @apptypes = Apptype.find(:all, :order => "abbrev").map {|apt| [apt.namechain_naked, apt.id]}

    if param_posted?(:appellation)
      if @appellation.update_attributes(params[:appellation])
        flash[:notice] = "#{@appellation.namechain_naked} (#{@appellation.id}) updated"
        redirect_to :action => "index"
      end
    end    
  end

  def search
    @title = "Search Appellations"
    if params[:q]
      query = params[:q]
      @appellations = Appellation.paginate(:conditions => ["UPPER(name) like UPPER(?)", '%'+query+'%'], 
                                           :page => params[:page], :order => Appellation::QUERY_RETURN_ORDER)
    end
  end
end
