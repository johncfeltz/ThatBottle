require File.dirname(__FILE__) + '/../test_helper'

class GrapeTest < ActiveSupport::TestCase
  fixtures :grapes
  
  def setup
    @valid_grape = grapes(:valid_grape)
    @invalid_grape = grapes(:invalid_grape)
    @error_messages = ActiveRecord::Errors.default_error_messages
  end

  # this grape should be valid by construction
  def test_grape_validity
    assert @valid_grape.valid?
  end
  
  # this grape should be invalid by construction
  def test_country_invalidity
    assert !@invalid_grape.valid?
    attributes = [:name]
    attributes.each do |attribute|
      assert @invalid_grape.errors.invalid?(attribute)
    end
  end
  
  # make sure name can't be too short
  def test_name_min_length
    grape = @valid_grape
    min_len = Grape::NAME_MIN_LENGTH
    
    #name too short
    grape.name = "a" * (min_len-1)
    assert !grape.valid?, "#{grape.name} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    assert_equal correct_error_message, grape.errors.on(:name)
    
    #name is exactly minimum length
    grape.name = "a" * min_len
    assert grape.valid?, "#{grape.name} should be just long enough to pass"
  end
  
  # make sure name can't be too long
  def test_name_max_length
    grape = @valid_grape
    max_len = Grape::NAME_MAX_LENGTH
    
    #name too long
    grape.name = "a" * (max_len+1)
    assert !grape.valid?, "#{grape.name} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, grape.errors.on(:name)
    
    #name is exactly maximum length
    grape.name = "a" * max_len
    assert grape.valid?, "#{grape.name} should be just short enough to pass"
  end
end
