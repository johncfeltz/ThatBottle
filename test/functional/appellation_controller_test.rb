require File.dirname(__FILE__) + '/../test_helper'
require 'appellation_controller'

class AppellationControllerTest < ActionController::TestCase

# Make sure the create page responds with the correct form
  def test_create_page
    get :new
    title = assigns(:title)
    assert_equal "Enter a New Wine Region", title
    assert_response :success
    assert_template "new"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/appellation/new", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "appellation[name]", :type => "text",
                                :size => Appellation::NAME_SIZE,
                                :maxlength => Appellation::NAME_MAX_LENGTH }
    assert_tag "select",
               :attributes => { :name => "appellation[apptype_id]" }
    assert_tag "select",
               :attributes => { :name => "appellation[parentappellation_id]" }
    assert_tag "textarea",
               :attributes => { :name => "appellation[notes]",
                                :cols => Appellation::NOTES_HORIZ_SIZE,
                                :rows => Appellation::NOTES_VERT_SIZE }
    assert_tag "input", :attributes => { :type => "submit", :value => "Save"}
  end
  
#Test a valid create
  def test_create_success
    post :new, :appellation => { :name        => "Cahors",
                                 :apptype_id  => "1",
                                 :notes       => "original home of Malbec" }
    #test assignment of appellation
    appellation = assigns(:appellation)
    assert_not_nil appellation
    #test new appelation is in db
    new_appellation = Appellation.find_by_name_and_apptype_id(appellation.name, appellation.apptype_id)
    assert_equal new_appellation, appellation
    #test flash and redirect
    assert_equal "#{appellation.name} #{appellation.apptype.namechain} saved", flash[:notice]
    assert_redirected_to :action => "index", :controller => "appellation"
  end

#Test an invalid create
  def test_create_failure
    post :new, :appellation => { :name       => "",
                                 :apptype_id => 1 }
    assert_response :success   #success of HTTP, not success of create process
    assert_template "new"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Name/
 
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "appellation[name]",
                                :value => ""},
               :parent => error_div
  end
end