#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/country_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on wine-producing Countries
#
#########################################################################################################

class CountryController < ApplicationController
  include ApplicationHelper
  before_filter :redirect_if_forbidden
  
  def index   # from RailsSpace chapter 10
    @title = "Wine Growing Countries"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
    @initial = !params[:id].nil? ? params[:id] : "A"
    @countries = Country.paginate(:conditions => ["name like ?", @initial+'%'], 
                           :page => params[:page], :order => Country::QUERY_RETURN_ORDER) 
  end
  
  def list
    @title = "List of Wine Growing Countries"
    @countries = Country.find(:all, :order => Country::QUERY_RETURN_ORDER) 
  end
  
  def show
    @apptypes = Apptype.find(:all, :conditions => ["country_id = ?", params[:id]],
                              :order => "abbrev")
    @country = Country.find(params[:id])
    @title = "Country Details: #{@country.name}"
  end
  
  def new
    @title = "Enter a New Wine Growing Country"
    if param_posted?(:country)
      @country = Country.new(params[:country])
      if @country.save
        flash[:notice] = "#{@country.name} saved"
        redirect_to :action => "index"
      end
    end
  end

  def edit
    @country = Country.find(params[:id])
    @title = "Edit Country: #{@country.name}"
    if param_posted?(:country)
      if @country.update_attributes(params[:country])
        flash[:notice] = "#{@country.name} (#{@country.id}) updated"
        redirect_to :action => "index"
      end
    end
  end

  def search
    @title = "Search Countries"
    if params[:q]
      query = params[:q]
      @countries = Country.paginate(:conditions => ["UPPER(name) like UPPER(?) OR isocode_2let like" +
                                   " UPPER(?) OR isocode_3let like UPPER(?) OR isocode_num like ?", 
                                   '%'+query+'%', '%'+query+'%', '%'+query+'%', '%'+query+'%'], 
                                   :page => params[:page], :order => Country::QUERY_RETURN_ORDER)
    end
  end
end  
