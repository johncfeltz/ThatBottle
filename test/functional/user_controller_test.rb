require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'

class UserControllerTest < ActionController::TestCase

# Make sure the registration page responds with the correct form
  def test_registration_page
    get :register
    title = assigns(:title)
    assert_equal "Join", title
    assert_response :success
    assert_template "register"
    # test the form and all its tags
    assert_tag "form", :attributes => { :action => "/user/register", :method => "post"}
    assert_tag "input",
               :attributes => { :name => "user[handle]", :type => "text",
                                :size => User::HANDLE_SIZE,
                                :maxlength => User::HANDLE_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "user[fullname]", :type => "text",
                                :size => User::FULLNAME_SIZE,
                                :maxlength => User::FULLNAME_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "user[email]", :type => "text",
                                :size => User::EMAIL_SIZE,
                                :maxlength => User::EMAIL_MAX_LENGTH }
    assert_tag "input",
               :attributes => { :name => "user[password]", :type => "password",
                                :size => User::PASSWORD_SIZE,
                                :maxlength => User::PASSWORD_MAX_LENGTH }
    assert_tag "input", :attributes => { :type => "submit", :value => "Join!"}
  end
  
#Test a valid registration
  def test_registration_success
    post :register, :user => { :handle => "test_handle",
                               :fullname => "test full name",
                               :email => "test@test.com",
                               :password => "pa$$w0rd"}
    #test assignment of user
    user = assigns(:user)
    assert_not_nil user
    #test new user is in db
    new_user = User.find_by_handle_and_password(user.handle, user.password)
    assert_equal new_user, user
    #test flash and redirect
    assert_equal "User #{new_user.handle} registered!", flash[:notice]
    assert_redirected_to :action => "index", :controller => "static"
  end

#Test an invalid registration
  def test_registration_failure
    post :register, :user => { :handle => "aa/noyes",
                               :fullname => "aa",
                               :email => "f@,a",
                               :password => "a"}
    assert_response :success   #success of HTTP, not success of registration process
    assert_template "register"
    #test display of error messages
    assert_tag "div", :attributes => { :id => "errorExplanation",
                                       :class => "errorExplanation"}
    #test that each form field has at least one error diplayed
    assert_tag "li", :content => /Handle/
    assert_tag "li", :content => /Fullname/
    assert_tag "li", :content => /Email/
    assert_tag "li", :content => /Password/
    
    #test to see that the input fields are being wrapped with the correct div
    error_div = { :tag => "div", :attributes => { :class => "fieldWithErrors"}}
    
    assert_tag "input",
               :attributes => { :name => "user[handle]",
                                :value => "aa/noyes"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "user[fullname]",
                                :value => "aa"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "user[email]",
                                :value => "f@,a"},
               :parent => error_div
    assert_tag "input",
               :attributes => { :name => "user[password]",
                                :value => "a"},
               :parent => error_div
  end
end
