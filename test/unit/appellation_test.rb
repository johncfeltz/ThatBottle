require File.dirname(__FILE__) + '/../test_helper'

class AppellationTest < ActiveSupport::TestCase
  fixtures :appellations

  def setup
    @valid_appellation_1 = appellations(:valid_appellation_1)
    @valid_appellation_2 = appellations(:valid_appellation_2)
    @invalid_appellation = appellations(:invalid_appellation)
    @error_messages = ActiveRecord::Errors.default_error_messages
    @cantbeblankmsg = "can't be blank"
  end

  # these two appellations should be valid by construction (but order is important!!!)
  def test_appellation_validity
    assert @valid_appellation_1.valid?
    assert @valid_appellation_2.valid?
  end
  
  # this appellation should be invalid by construction
  def test_appellation_invalidity
    assert !@invalid_appellation.valid?
    attributes = [:name, :apptype_id]
    attributes.each do |attribute|
      assert @invalid_appellation.errors.invalid?(attribute)
    end
  end
  
  # make sure name can't be too short
  def test_name_min_length
    appellation = @valid_appellation_1
    min_len = Appellation::NAME_MIN_LENGTH
    
    #name too short
    appellation.name = "a" * (min_len-1)
    assert !appellation.valid?, "#{appellation.name} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    appellation.errors.on(:name).each do |errormsg|
      if errormsg != @cantbeblankmsg
        assert_equal correct_error_message, errormsg
      else
        assert_equal @cantbeblankmsg, errormsg
      end
    end
    
    #name is exactly minimum length
    appellation.name = "a" * min_len
    assert appellation.valid?, "#{appellation.name} should be just long enough to pass"
  end
  
  # make sure name can't be too long
  def test_name_max_length
    appellation = @valid_appellation_1
    max_len = Appellation::NAME_MAX_LENGTH
    
    #name too long
    appellation.name = "a" * (max_len+1)
    assert !appellation.valid?, "#{appellation.name} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, appellation.errors.on(:name)
    
    #name is exactly maximum length
    appellation.name = "a" * max_len
    assert appellation.valid?, "#{appellation.name} should be just short enough to pass"
  end

end
