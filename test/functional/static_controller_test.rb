require File.dirname(__FILE__) + '/../test_helper'
require 'static_controller'

class StaticControllerTest < ActionController::TestCase

# Test page accessibility and titling
  def test_index
    get :index
    title = assigns(:title)
    assert_equal "ThatBottle.com - The Community for Wine Lovers", title
    assert_response :success
    assert_template "index"
  end
  def test_about
    get :about
    title = assigns(:title)
    assert_equal "About ThatBottle", title
    assert_response :success
    assert_template "about"
  end
  def test_help
    get :help
    title = assigns(:title)
    assert_equal "Help", title
    assert_response :success
    assert_template "help"
  end
  def test_legal
    get :legal
    title = assigns(:title)
    assert_equal "Legal Notices", title
    assert_response :success
    assert_template "legal"
  end
  def test_credit
    get :credit
    title = assigns(:title)
    assert_equal "Credits and Thanks", title
    assert_response :success
    assert_template "credit"
  end

end
