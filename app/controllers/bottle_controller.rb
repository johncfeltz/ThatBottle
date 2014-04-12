#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/bottle_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Bottles
#
#########################################################################################################

class BottleController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
  def index   # how do I want to index a user's bottles?  By wine name?  By number?
    @user = User.find_by_id(current_user)
    @cellar = @user.cellar
    @bottles = Bottle.find(:all, :conditions => ["cellar_id = ?", @cellar.id],
                           :order => "cellarnum")
    @title = "Inventory of My Bottles"
  end
  
  def list
    @user = User.find_by_id(current_user)
    @cellar = @user.cellar
    @bottles = Bottle.find(:all, :conditions => ["cellar_id = ?", @cellar.id],
                           :order => "cellarnum")
    @title = "Inventory of My Bottles"
  end
  
  def new     # single or multiple bottles
    @title = "Record New Bottles"
    # arrays to pass in for select statements.  
    @wines = Wine.find(:all, :order => "name, producer, winecolor_id").map {|w| [w.namechain_long, w.id]}
#    @cellar =  cellar of currently logged in user -- free users can't create bottles
    @cellar = Cellar.find(:first, :conditions => ["id = 1"])
    
    if param_posted?(:bottle)   
      numbotts = params["numbotts"].to_f.to_int  # pull numbotts out of the :param list
      1.step(numbotts, 1) do |bottnum|
        @bottle = Bottle.new(params[:bottle])
        @bottle.disptype_id = 0
        @bottle.cellar_id = @cellar
        @bottle.cellarnum = @cellar.topbottlenumber + bottnum
        @bottle.save
      end
      @cellar.topbottlenumber += numbotts
      @cellar.save
 
      if numbotts == 1
        flash[:notice] = "#{@cellar.user.handle}'s bottle ##{@cellar.topbottlenumber} " +
                         "(#{@bottle.wine.nameproducer}) saved"
      else
        flash[:notice] = "#{@cellar.user.handle}'s bottles ##{(@cellar.topbottlenumber - numbotts +1)} " +
                         "to ##{@cellar.topbottlenumber} (#{@bottle.wine.nameproducer}) saved"
      end
      redirect_to :action => "list"   # not sure about where to go from here...
    end 
  end

  def dispose
    @title = "Bottle Disposition"    
    if param_posted?(:bottle)
      @bottle.cellarlabel = nil
      @bottle.cellarlocation = nil
      if @cellar.save
        flash[:notice] = "Bottle #{@bottle.cellarnum} disposed of via #{@bottle.disptype.disptype}"
        redirect_to :action => "index"
      end
    end
  end
  
  def show
    @title = "Bottle Details"
    @bottle = Bottle.find(params[:id])
  end

  def edit
    @bottle = Bottle.find(params[:id])
    @title = "Edit Bottle Details: ##{@bottle.cellarnum} - #{@bottle.namechain}"
  end

end
