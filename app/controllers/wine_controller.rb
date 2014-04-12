#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/wine_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Wines
#
#########################################################################################################

class WineController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
  def index    # from RailsSpace chapter 10
    @title = "Wines"
    @initial = !params[:id].nil? ? params[:id] : "A"
    @wines = Wine.paginate(:conditions => ["name like ?", @initial+'%'],
                           :page => params[:page], :order => Wine::QUERY_RETURN_ORDER)   
  end
  
  def list
    @title = "List of Wines"
    @wines = Wine.find(:all, :order => Wine::QUERY_RETURN_ORDER)
  end

  def new
    @title = "Enter a New Wine"
    # arrays to pass in for select statements.  
    @appellations  = Appellation.find(:all, :order => "name").map {|a| [a.namechain_naked, a.id]}
    @winecolors = Winecolor.find(:all, :order => "id").map {|wc| [wc.winecolor, wc.id]}
    @winetypes  = Winetype.find(:all,  :order => "id").map {|wt| [wt.winetype, wt.id]}
    
    if param_posted?(:wine)
      @wine = Wine.new(params[:wine])
      if @wine.save
        flash[:notice] = "#{@wine.namechain} saved"
        redirect_to :action => "index"
      end
    end
  end

  def show
    @wine = Wine.find(params[:id])
    @title = "Wine Details: #{@wine.name}"
    @user = User.find(:first, :conditions => ["id = 1"])    # use sessions for this...
    @cellar = Cellar.find(:first, :conditions => ["user_id = ?", @user.id])
    @bottles = Bottle.find(:all, :conditions => ["cellar_id = ? and wine_id = ?", 
                            @cellar.id, @wine.id], :order => "cellarnum")  
  end

  def edit
    @wine = Wine.find(params[:id])
    @title = "Edit Wine: #{@wine.namechain}"
    # arrays to pass in for select statements.  
    @appellations  = Appellation.find(:all, :order => "name").map {|a| [a.namechain_naked, a.id]}
    @winecolors = Winecolor.find(:all, :order => "id").map {|wc| [wc.winecolor, wc.id]}
    @winetypes  = Winetype.find(:all,  :order => "id").map {|wt| [wt.winetype, wt.id]}

    if param_posted?(:wine)
      if @wine.update_attributes(params[:wine])
        flash[:notice] = "#{@wine.namechain} (#{@wine.id}) updated"
        redirect_to :action => "index"
      end
    end
  end

  def search
    @title = "Search Wines"
    if params[:q]
      query = params[:q]
#      @wines = Wine.find_by_contents(query, :order => Wine::QUERY_RETURN_ORDER)  # ferret, eventually...
      @wines = Wine.paginate(:conditions => ["UPPER(name) like UPPER(?) OR UPPER(producer) like UPPER(?)", 
                              '%'+query+'%', '%'+query+'%'],
                              :page => params[:page], :order => Wine::QUERY_RETURN_ORDER)
    end
  end
end
