#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/apptype_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Appellation Types (i.e., legally or historically defined types or categories of 
#   named wine regions)
#
#########################################################################################################

class ApptypeController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
    
  def index      # from RailsSpace chapter 10
    @title = "Appellation Types"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    @initial = !params[:id].nil? ? params[:id] : "A"
    @apptypes = Apptype.paginate(:conditions => ["abbrev like ?", @initial+'%'],
                                 :page => params[:page], :order => Apptype::QUERY_RETURN_ORDER)
  end
  
  def list
    @apptypes = Apptype.find(:all, :order => Apptype::QUERY_RETURN_ORDER)
    @title = "List of Appellation Types"
  end

  def new
    @title = "Enter a New Appellation Type"
    # arrays to pass in for select statements.  NIL first entry for apptypes because not every apptype has
    #   a next higher.  No NIL first entry for country because every appellation type is defined by national
    #   law or custom (that is, until the EU starts defining european-wide regions.  Eek!)
    @apptypes  = [[nil,"(none)"]] + Apptype.find(:all, :order => "abbrev").map {|apt| [apt.namechain_naked, apt.id]}
    @countries = Country.find(:all, :order => "name").map {|cou| [cou.name, cou.id]}
                              
    if param_posted?(:apptype)
      @apptype = Apptype.new(params[:apptype])
      if @apptype.save
        flash[:notice] = "#{@apptype.namechain} saved"
        redirect_to :action => "index"
      end
    end
  end

  def show
    @apptype = Apptype.find(params[:id])
    @appellations = Appellation.paginate(:conditions => ["apptype_id = ?", params[:id]],
                                 :page => params[:page], :order => "name")
    @title = "Appellation Type Details: #{@apptype.namechain}"
  end

  def edit
    @apptype = Apptype.find(params[:id])
    @title = "Edit Appellation Type: #{@apptype.namechain}"
    # arrays to pass in for select statements.  NIL first entry for apptypes because not every apptype has
    #   a next higher.  No NIL first entry for country because every appellation type is defined by national
    #   law or custom (that is, until the EU starts defining european-wide regions.  Eek!)
    @apptypes  = [[nil,"(none)"]] + Apptype.find(:all, :order => "abbrev").map {|apt| [apt.namechain_naked, apt.id]}
    @countries = Country.find(:all, :order => "name").map {|cou| [cou.name, cou.id]}

    if param_posted?(:apptype)
      if @apptype.update_attributes(params[:apptype])
        flash[:notice] = "#{@apptype.namechain} (#{@apptype.id}) updated"
        redirect_to :action => "index"
      end
    end    
  end
  
  def search
    @title = "Search Appellation Types"
    if params[:q]
      query = params[:q]
      @apptypes = Apptype.paginate(:conditions => ["UPPER(abbrev) like UPPER(?) OR UPPER(fullname) like" +
                                   " UPPER(?) OR UPPER(translation) like UPPER(?)", '%'+query+'%', '%'+query+'%',
                                   '%'+query+'%'], :page => params[:page], :order => Apptype::QUERY_RETURN_ORDER)
    end
  end
end
