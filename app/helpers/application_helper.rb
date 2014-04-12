# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
# Return a link for use in layout navigation.

# corresponds to div = topnav or div = topnav2
  def nav_link(text, controller, action="index")  
    link_to_unless_current text, :id => nil, :controller => controller, :action => action
  end

# corresponds to div = topnav2
# change this to include check for session!!
  def tasknav_link(text, action)                  
    link_to text, :id => nil, :controller => "task", :action => action 
  end
  
  def img_nav_link(img, alt_text, controller, action="index")   # corresponds to div = header
  end

  #Determine user login status and ID of currently logged-in user
  def logged_in?
    not session[:user_id].nil?
  end

  def current_user
    session[:user_id]
  end

#############################  
##
##  Role-based authentication.
##  As of Beta 2 (July/August 2008), this is simple enough to represent with programatic logic, not
##  a database implementation like many plugins use.  We'll see what happens over time.  I need to
##  read the friendship section of the RailsSpace book to see how they approach modelling that part
##  of the RBA problem (especially as relates to blog posts and comments on blog posts), and possibly
##  apply that to the issue of my bottles, vs my bottles that my friends can see & post tasting notes
##  on (at a tasting event), vs my bottles that everyone can see (because I want to brag about my 1945
##  Bordeaux and 2000 Barolos).
##
############################  

# RBA helper methods - all return true/false based on simple criteria.
#
# I need to create parallel methods/string values for search strings
#

#
# These deal with user status and the beta test community
#
  def is_admin?
    return false unless logged_in?
    user = User.find_by_id(current_user)
    user.userstatus.status == "admin" ? true : false
  end
  
  def is_full?
    return false unless logged_in?
    user = User.find_by_id(current_user)
    user.userstatus.status == "full" ? true : false    
  end

  def is_pro?
    return false unless logged_in?
    user = User.find_by_id(current_user)
    user.userstatus.status == "pro" ? true : false    
  end

  def is_free?
    return false unless logged_in?
    user = User.find_by_id(current_user)
    user.userstatus.status == "free" ? true : false
  end
  
  def is_beta?
    return false unless logged_in?
    user = User.find_by_id(current_user)
    user.betauser == 1 ? true : false    
  end

#
# These determine the current user's relationship to a given bottle.  The main RBA function
# below expands these true/false values into rights to a controller/action/id tuple.
# Types of relationship:
#   1. ownership -- which the RBA function will grant full rights to,
#   2. public bottle -- main RBA grants list and view only,
#   3. friends' bottle -- see below for more discussion.
#

  def is_my_bottle?(id)
    bottle = Bottle.find_by_id(id)
    bottle.cellar.user_id == current_user ? true : false
  end
  
  def is_public_bottle?(id)     # MODEL NOT IMPLEMENTED YET
#    bottle = Bottle.find_by_id(id)
#    bottle.public ? true: false
  return false
  end

# NOT IMPLEMENTED YET
# NOT EVEN SURE HOW I WANT TO DO IT...  Split into 2 parts?
#     If my friend makes his cellar viewable to all friends, then I can see the list and the details only.
#     On the other hand, if he contributes the bottle to a tasting event that I've been invited to, 
#     then I can create a tasting note.
  def is_friends_bottle?(id)                             
# ......
# ......
  return false
  end
  
#
# These determine the current user's relationship to a given tasting note.  The main RBA function
# below expands these true/false values into rights to a controller/action/id tuple.
# Types of relationship:
#   1. ownership -- which the RBA function will grant full rights upon,
#   2. public tasting note, due to being recently created (as of Jul 2008 the Tastingnote model
#      has a constant FREE_MEMBER_HORIZON = 30 days) -- main RBA grants list and view only,
#   3. friends' tasting note (similar conditions and discussion as for friends' bottle)
#

  def is_my_tnote?(id)
    tnote = Tastingnote.find_by_id(id)  
    tnote.user_id == current_user ? true : false
  end

  def is_public_tnote?(id)
    tnote = Tastingnote.find_by_id(id)
    cutoff_date = Date.today - Tastingnote::FREE_MEMBER_HORIZON
    tnote.created_at >= cutoff_date ? true : false
  end

##############################################################################################
#  
# The actual RBA implementation.  Returns true/false based on:
#  * controller/action/id tuple (arguments),
#  * user status (determined from session variable)
#  * intrinsic properties of some object instances (owner of a bottle or tasting note, 
#        create date of a tasting note, etc.)
#
##############################################################################################
  
  def is_allowed?(controller=params[:controller], action=params[:action], id=params[:id])
    case controller
    when "admin"
      return is_admin?
    
    when "user"
      case action
      when "register"
        return !logged_in?
      when "login"
        return !logged_in?
      when "logout"
        return logged_in?
      when "show", "edit"
        return ((is_admin?) || (current_user == id))
      when "list", "index"
        return logged_in?
      when "pay"
        return is_beta?
      end
      
    when "country", "grape", "apptype", "appellation"    #basic ERD viewable to all
      case action 
      when "delete", "edit", "new"
        return ((is_admin? || is_full? || is_pro?))
      else
        return true
      end
        
    when "wine"                     #basic ERD viewable ONLY to members
      case action
      when "index", "list"
        return true
      when "delete"
        return is_admin?
      when "edit"
        return (is_admin? || is_full? || is_pro?)
      else
        return logged_in?
      end
        
    when "bottle"                         # these two will get more complicated w/ friendship model
      return false unless logged_in?
      if is_free?
        return false
      end
      case action
      when "index", "list"
        return (is_admin? || is_full?)
      else
        return (is_my_bottle? || is_admin?)
      end

    when "tastingnote"
      return false unless logged_in?
      case action
      when "index", "list"
        return (is_admin? || is_full?)
      when "new_w"
        return logged_in?
      when "new_b"
        return (is_full? && is_my_bottle?(id)) 
      else
        return (is_my_tnote? || is_admin?)
      end
    
    else                          # catch-all
      return is_admin?
    end

  end
  
# RBA definition of default "bad boy, you can't go there page"
# I should probably copy that to the default HTTP page as well (500??)
  def redirect_if_forbidden
    redirect_to :controller => "static", :action => "forbidden" unless is_allowed?
  end
  
# Depreccated.  Remove references once before_filter is completely working.
  def redirect_to_forbidden
    redirect_to :controller => "static", :action => "forbidden"
  end  
  
end
