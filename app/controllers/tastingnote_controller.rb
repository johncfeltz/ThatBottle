#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/tastingnote_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Tasting Notes
#
#########################################################################################################
#
# Since this is polymorphic, I need to have separate actions for bottle->tastingnote (**_b) and
#   wine->tastingnote (**_w) relationships.  Try to find a way to dry up these actions and views.
#
#########################################################################################################

class TastingnoteController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
# how do I want to index a user's tasting notes?  By wine name?  By number?  By date?
  def index    
    list
    render :action => "list"
  end
  
  def list
    @title = "List of Tasting Notes"
    @tnotes = Tastingnote.find(:all, :order => Tastingnote::QUERY_RETURN_ORDER)
  end

  def new_b
    @bottle = Bottle.find(params[:id])
    @title = "New Tasting Note for #{@bottle.ownerchain}"
    if param_posted?(:tastingnote)
      @tastingnote = Tastingnote.new(params[:tastingnote])
      @tastingnote.vintage = @bottle.vintage
      @tastingnote.user_id = @bottle.cellar.user_id    # do by sessions!
      @tastingnote.tasteable_id = @bottle.id
      @tastingnote.tasteable_type = "Bottle"
      if @tastingnote.save
        @bottle.disptype_id = 1       # consumption
        @bottle.cellarlabel = nil
        @bottle.cellarlocation = nil
        @bottle.save
        flash[:notice] = "Tasting note for #{@bottle.ownerchain} saved; #{@bottle.ownerchain} removed from inventory."
        redirect_to :action => "index", :controller => "bottle"
      end
    end
  end

  def show_b
#    @wine = Wine.find(params[:id])
#    @title = "Wine Details: #{@wine.name}"
#    @user = User.find(:first, :conditions => ["id = 1"])    # use sessions for this...
#    @cellar = Cellar.find(:first, :conditions => ["user_id = ?", @user.id])
#    @bottles = Bottle.find(:all, :conditions => ["cellar_id = ? and wine_id = ?", 
#                            @cellar.id, @wine.id], :order => "cellarnum")  
  end
  
  def new_w
    @wine = Wine.find(params[:id])    
    @title = "New Tasting Note for #{@wine.namechain}"
    if param_posted?(:tastingnote)
      @tastingnote = Tastingnote.new(params[:tastingnote])
      @tastingnote.user_id = 1      # do by sessions!
      @tastingnote.tasteable_id = @wine.id
      @tastingnote.tasteable_type = "Wine"
      if @tastingnote.save
        flash[:notice] = "Tasting note for #{@wine.name} saved"
        redirect_to :action => "index", :controller => "wine"
      end
    end
  end

  def show_w
#    @wine = Wine.find(params[:id])
#    @title = "Wine Details: #{@wine.name}"
#    @user = User.find(:first, :conditions => ["id = 1"])    # use sessions for this...
#    @cellar = Cellar.find(:first, :conditions => ["user_id = ?", @user.id])
#    @bottles = Bottle.find(:all, :conditions => ["cellar_id = ? and wine_id = ?", 
#                            @cellar.id, @wine.id], :order => "cellarnum")  
  end

  def edit_b
    @tastingnote = Tastingnote.find(params[:id])
    @title = "Edit Tasting Note"

    if param_posted?(:tastingnote)
      if @tastingnote.update_attributes(params[:tastingnote])
        flash[:notice] = "Tasting Note updated"
        redirect_to :action => "index"
      end
    end
  end

  def edit_w
    @tastingnote = Tastingnote.find(params[:id])
    @title = "Edit Tasting Note"

    if param_posted?(:tastingnote)
      if @tastingnote.update_attributes(params[:tastingnote])
        flash[:notice] = "Tasting Note updated"
        redirect_to :action => "index"
      end
    end
  end
  
  def search
    @title = "Search Tasting Notes"
    if params[:q]
      query = params[:q]
#      @wines = Wine.find_by_contents(query, :order => Wine::QUERY_RETURN_ORDER)  # ferret, eventually...
#      @tnotes = Tastingnote.paginate(:conditions => ["UPPER(name) like UPPER(?) OR UPPER(producer) like UPPER(?)", 
#                              '%'+query+'%', '%'+query+'%'],
#                              :page => params[:page], :order => Wine::QUERY_RETURN_ORDER)
    end
  end

end
