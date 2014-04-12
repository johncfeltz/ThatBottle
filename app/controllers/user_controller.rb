#########################################################################################################
#
# Project:  ThatBottle
# File:     app/controllers/user_controller.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# CRUD actions on Users.
# Most logic for logins, logouts, security, and RBA goes here and in associated model and helper files,
#   as well as the application_helper file.
#
#########################################################################################################
#
# Significant progress made in July 2008
#
#########################################################################################################

class UserController < ApplicationController
  include ApplicationHelper
  require 'digest/sha2'
  before_filter :redirect_if_forbidden
  
  def index  #lots of permission stuff here: public profile (w/ filters), private profile, admin view of profiles, etc.
    @title = "My ThatBottle"
  end
  
  def list
    @users = User.find(:all, :order => "handle") 
    @title = "List of Users"
  end

  def show  # private to admins and each user
    @title = "User Details"
  end

  def register  # aka new
    @title = "Sign Up"
    if param_posted?(:user)
      @user = User.new(params[:user])
      @user.setstatus!("free") 
      @user.betauser = 0
      if @user.save
        @user.login!(session)
        flash[:notice] = "Welcome to ThatBottle, #{@user.handle}!"
        @user.lastlogin = Time.now
        @user.save
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
  end

  def pay   # set status to 3 (full) and create a cellar
    @title = "Pay for Full Membership"
    @user = User.find_by_id(current_user)
    @user.setstatus!("full") 
    @user.save
    @cellar = Cellar.new
    @cellar.user_id = @user
    @cellar.save
  end
  
  def edit  # private to each user
    @title = "Change My Details"
  end
  
  def login
    @title = "Log in to ThatBottle"
    if request.get?
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_handle_and_password(@user.handle, @user.password)
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        flash[:notice] = "Welcome back, #{user.handle} - your last login was #{user.lastlogin}"
        user.lastlogin = Time.now
        user.save
        redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = "Invalid handle and/or password"
      end
    end  
  end

  def logout
    User.logout!(session, cookies)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "static"
  end

  private
    
  # Redirect to the previously requested URL (if present)
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
  
  # Returns string with the status of the "remember me?" checkbox
  def remember_me_string
    cookies[:remember_me] || "0"
  end
end

