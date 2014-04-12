require File.dirname(__FILE__) + '/../test_helper'
require 'grape_controller'

class GrapeControllerTest < ActionController::TestCase

# Make sure the create page responds with the correct form
  def test_create_page
    get :new
    title = assigns(:title)
    assert_equal "Enter a New Wine Grape", title
    assert_response :success
    assert_template "new"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/grape/new", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "grape[name]", :type => "text",
                                :size => Grape::NAME_SIZE,
                                :maxlength => Grape::NAME_MAX_LENGTH }
    assert_tag "textarea",
               :attributes => { :name => "grape[notes]",
                                :cols => Grape::NOTES_HORIZ_SIZE,
                                :rows => Grape::NOTES_VERT_SIZE }
    assert_tag "input", :attributes => { :type => "submit", :value => "Save"}
  end
  
#Test a valid create
  def test_create_success
    post :new, :grape => { :name =>         "Tinta Roriz",
                           :notes =>        "blah blah" }
    #test assignment of country
    grape = assigns(:grape)
    assert_not_nil grape
    #test new grape is in db
    new_grape = Grape.find_by_name(grape.name)
    assert_equal new_grape, grape
    #test flash and redirect
    assert_equal "#{grape.name} saved", flash[:notice]
    assert_redirected_to :action => "index", :controller => "grape"
  end

#Test an invalid create
  def test_create_failure
    post :new, :grape => { :name =>         "", }
    assert_response :success   #success of HTTP, not success of registration process
    assert_template "new"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Name/
    
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "grape[name]",
                                :value => ""},
               :parent => error_div
  end
  
# Test the show page

# Test the index (list) page

# Test the edit page

end