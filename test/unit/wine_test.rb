require File.dirname(__FILE__) + '/../test_helper'

class WineTest < ActiveSupport::TestCase
  fixtures :wines

  def setup
    @valid_wine = wines(:valid_wine)
    @invalid_wine = wines(:invalid_wine)
    @error_messages = ActiveRecord::Errors.default_error_messages
    @cantbeblankmsg = "can't be blank"
  end
  
  # this wine should be valid by construction
  def test_wine_validity
    assert @valid_wine.valid?
  end
  
  # this wine should be invalid by construction
  def test_wine_invalidity
    assert !@invalid_wine.valid?
    attributes = [:name, :appellation_id, :winecolor_id, :winetype_id]
    attributes.each do |attribute|
      assert @invalid_wine.errors.invalid?(attribute)
    end
  end
  
  # make sure name can't be too short
  def test_name_min_length
    wine = @valid_wine
    min_len = Wine::NAME_MIN_LENGTH
    
    #name too short
    wine.name = "a" * (min_len-1)
    assert !wine.valid?, "#{wine.name} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    wine.errors.on(:name).each do |errormsg|
      if errormsg != @cantbeblankmsg
        assert_equal correct_error_message, errormsg
      else
        assert_equal @cantbeblankmsg, errormsg
      end
    end
    
    #name is exactly minimum length
    wine.name = "a" * min_len
    assert wine.valid?, "#{wine.name} should be just long enough to pass"
  end
  
  # make sure name can't be too long
  def test_name_max_length
    wine = @valid_wine
    max_len = Wine::NAME_MAX_LENGTH
    
    #name too long
    wine.name = "a" * (max_len+1)
    assert !wine.valid?, "#{wine.name} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, wine.errors.on(:name)
    
    #name is exactly maximum length
    wine.name = "a" * max_len
    assert wine.valid?, "#{wine.name} should be just short enough to pass"
  end

  # make sure producer can't be too long
  def test_producer_max_length
    wine = @valid_wine
    max_len = Wine::PRODUCER_MAX_LENGTH
    
    #producer too long
    wine.producer = "a" * (max_len+1)
    assert !wine.valid?, "#{wine.producer} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, wine.errors.on(:producer)
    
    #producer is exactly maximum length
    wine.producer = "a" * max_len
    assert wine.valid?, "#{wine.producer} should be just short enough to pass"
  end
end
