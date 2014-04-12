require File.dirname(__FILE__) + '/../test_helper'
require 'country_controller'

class CountryControllerTest < ActionController::TestCase

# Make sure the create page responds with the correct form
  def test_create_page
    get :new
    title = assigns(:title)
    assert_equal "Enter a New Wine Growing Country", title
    assert_response :success
    assert_template "new"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/country/new", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "country[name]", :type => "text",
                                :size => Country::NAME_SIZE,
                                :maxlength => Country::NAME_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "country[isocode_2let]", :type => "text",
                                :size => Country::ISOCODE_2LET_SIZE,
                                :maxlength => Country::ISOCODE_2LET_LENGTH }
    assert_tag "input",
               :attributes => { :name => "country[isocode_3let]", :type => "text",
                                :size => Country::ISOCODE_3LET_SIZE,
                                :maxlength => Country::ISOCODE_3LET_LENGTH }
    assert_tag "input",
               :attributes => { :name => "country[isocode_num]", :type => "text",
                                :size => Country::ISOCODE_NUM_SIZE,
                                :maxlength => Country::ISOCODE_NUM_LENGTH }
    assert_tag "textarea",
               :attributes => { :name => "country[notes]",
                                :cols => Country::NOTES_HORIZ_SIZE,
                                :rows => Country::NOTES_VERT_SIZE }
    assert_tag "input", :attributes => { :type => "submit", :value => "Save"}
  end
  
#Test a valid create
  def test_create_success
    post :new, :country => { :name =>         "New Zealand",
                             :isocode_2let => "NZ",
                             :isocode_3let => "NZL",
                             :isocode_num  => "103",
                             :notes =>        "Small boutique producer of Sauv Blanc and Pinot Noir" }
    #test assignment of country
    country = assigns(:country)
    assert_not_nil country
    #test new country is in db
    new_country = Country.find_by_name(country.name)
    assert_equal new_country, country
    #test flash and redirect
    assert_equal "#{country.name} saved", flash[:notice]
    assert_redirected_to :action => "index", :controller => "country"
  end

#Test an invalid create
  def test_create_failure
    post :new, :country => { :name =>         "New",
                             :isocode_2let => "NZL3",
                             :isocode_3let => "NZ",
                             :isocode_num  => "aa" }
    assert_response :success   #success of HTTP, not success of registration process
    assert_template "new"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Name/
    assert_tag "li", :content => /Isocode 2let/
    assert_tag "li", :content => /Isocode 3let/
    assert_tag "li", :content => /Isocode num/
    
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "country[name]",
                                :value => "New"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "country[isocode_2let]",
                                :value => "NZL3"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "country[isocode_3let]",
                                :value => "NZ"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "country[isocode_num]",
                                :value => "aa"},
               :parent => error_div
  end
end