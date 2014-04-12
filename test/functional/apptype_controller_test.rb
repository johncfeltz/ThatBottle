require File.dirname(__FILE__) + '/../test_helper'
require 'apptype_controller'

class ApptypeControllerTest < ActionController::TestCase

# Make sure the create page responds with the correct form
  def test_create_page
    get :new
    title = assigns(:title)
    assert_equal "Enter a Legal or Historical Category of Wine Region", title
    assert_response :success
    assert_template "new"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/apptype/new", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "apptype[abbrev]", :type => "text",
                                :size => Apptype::ABBREV_SIZE,
                                :maxlength => Apptype::ABBREV_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "apptype[fullname]", :type => "text",
                                :size => Apptype::FULLNAME_SIZE,
                                :maxlength => Apptype::FULLNAME_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "apptype[translation]", :type => "text",
                                :size => Apptype::TRANSLATION_SIZE,
                                :maxlength => Apptype::TRANSLATION_MAX_LENGTH }
    assert_tag "select",
               :attributes => { :name => "apptype[country_id]" }
    assert_tag "select",
               :attributes => { :name => "apptype[nexthigher_id]" }
    assert_tag "textarea",
               :attributes => { :name => "apptype[notes]",
                                :cols => Apptype::NOTES_HORIZ_SIZE,
                                :rows => Apptype::NOTES_VERT_SIZE }
    assert_tag "input", :attributes => { :type => "submit", :value => "Save"}
  end
  
#Test a valid create
  def test_create_success
    post :new, :apptype => { :abbrev      => "AVA",
                             :fullname    => "American Viticultural Area",
                             :translation => "(none)",
                             :country_id  => "1",
                             :notes       => "vast disparities in size" }
    #test assignment of apptype
    apptype = assigns(:apptype)
    assert_not_nil apptype
    #test new apptype is in db
    new_apptype = Apptype.find_by_abbrev_and_country_id(apptype.abbrev, apptype.country_id)
    assert_equal new_apptype, apptype
    #test flash and redirect
    assert_equal "#{apptype.abbrev} (#{apptype.fullname}) saved", flash[:notice]
    assert_redirected_to :action => "index", :controller => "apptype"
  end

#Test an invalid create
  def test_create_failure
    post :new, :apptype => { :abbrev       => "this is too long",
                             :fullname     => "",
                             :translation  => "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx" +
                                              "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcd",
                             :country_id   => "1" }
    assert_response :success   #success of HTTP, not success of create process
    assert_template "new"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Abbrev/
    assert_tag "li", :content => /Full/
    assert_tag "li", :content => /Translation/
    
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "apptype[abbrev]",
                                :value => "this is too long"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "apptype[fullname]",
                                :value => ""},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "apptype[translation]",
                                :value => "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx" +
                                          "abcdefghijklmnopqrstuvwx abcdefghijklmnopqrstuvwx abcd"},
               :parent => error_div
  end
end