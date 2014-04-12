require File.dirname(__FILE__) + '/../test_helper'
require 'wine_controller'

class WineControllerTest < ActionController::TestCase

# Make sure the create page responds with the correct form
  def test_create_page
    get :new
    title = assigns(:title)
    assert_equal "Enter a New Wine", title
    assert_response :success
    assert_template "new"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/wine/new", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "wine[name]", :type => "text",
                                :size => Wine::NAME_SIZE,
                                :maxlength => Wine::NAME_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "wine[producer]", :type => "text",
                                :size => Wine::PRODUCER_SIZE,
                                :maxlength => Wine::PRODUCER_MAX_LENGTH }
    assert_tag "select",
               :attributes => { :name => "wine[winecolor_id]" }
    assert_tag "select",
               :attributes => { :name => "wine[winetype_id]" }
    assert_tag "select",
               :attributes => { :name => "wine[appellation_id]" }
    assert_tag "textarea",
               :attributes => { :name => "wine[refs]",
                                :cols => Wine::REFS_HORIZ_SIZE,
                                :rows => Wine::REFS_VERT_SIZE }
    assert_tag "textarea",
               :attributes => { :name => "wine[notes]",
                                :cols => Wine::NOTES_HORIZ_SIZE,
                                :rows => Wine::NOTES_VERT_SIZE }
    assert_tag "input", :attributes => { :type => "submit", :value => "Save"}
  end
  
#Test a valid create
  def test_create_success
    post :new, :wine => { :name =>           "Beringer White Zinfandel",
                          :producer =>       "Beringer",
                          :winetype_id =>    "1",
                          :winecolor_id  =>  "3",
                          :appellation_id => "4",
                          :refs =>           "who cares...",
                          :notes =>          "You'll like this, if it's the kind of thing you like" }
    #test assignment of wine
    wine = assigns(:wine)
    assert_not_nil wine
    #test new wine is in db
    new_wine = Wine.find_by_name_and_producer(wine.name, wine.producer)
    assert_equal new_wine, wine
    #test flash and redirect
    assert_equal "#{wine.name} saved", flash[:notice]
    assert_redirected_to :action => "index", :controller => "wine"
  end

#Test an invalid create
  def test_create_failure
    post :new, :wine => { :name =>           "",
                          :producer =>       "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx ",
                          :refs =>           nil,
                          :notes =>          nil }
    assert_response :success   #success of HTTP, not success of registration process
    assert_template "new"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Name/
    assert_tag "li", :content => /Producer/
    assert_tag "li", :content => /Winetype/
    assert_tag "li", :content => /Winecolor/
    assert_tag "li", :content => /Appellation/
   
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "wine[name]",
                                :value => ""},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "wine[producer]",
                                :value => "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx "},
               :parent => error_div

  end
end