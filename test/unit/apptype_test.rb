require File.dirname(__FILE__) + '/../test_helper'

class ApptypeTest < ActiveSupport::TestCase
  fixtures :apptypes

  def setup
    @valid_apptype_1 = apptypes(:valid_apptype_1)
    @valid_apptype_2 = apptypes(:valid_apptype_2)
    @invalid_apptype = apptypes(:invalid_apptype)
    @error_messages = ActiveRecord::Errors.default_error_messages
    @cantbeblankmsg = "can't be blank"
  end

  # these two apptypes should be valid by construction (but order is important!!!)
  def test_apptype_validity
    assert @valid_apptype_1.valid?
    assert @valid_apptype_2.valid?
  end
  
  # this apptype should be invalid by construction
  def test_apptype_invalidity
    assert !@invalid_apptype.valid?
    attributes = [:abbrev, :fullname, :translation, :country_id]
    attributes.each do |attribute|
      assert @invalid_apptype.errors.invalid?(attribute)
    end
  end

  # make sure abbrev can't be too short
  def test_abbrev_min_length
    apptype = @valid_apptype_1
    min_len = Apptype::ABBREV_MIN_LENGTH
    
    #abbrev too short
    apptype.abbrev = "a" * (min_len-1)
    assert !apptype.valid?, "#{apptype.abbrev} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    apptype.errors.on(:abbrev).each do |errormsg|
      if errormsg != @cantbeblankmsg
        assert_equal correct_error_message, errormsg
      else
        assert_equal @cantbeblankmsg, errormsg
      end
    end
    
    #abbrev is exactly minimum length
    apptype.abbrev = "a" * min_len
    assert apptype.valid?, "#{apptype.abbrev} should be just long enough to pass"
  end
  
  # make sure abbrev can't be too long
  def test_abbrev_max_length
    apptype = @valid_apptype_1
    max_len = Apptype::ABBREV_MAX_LENGTH
    
    #abbrev too long
    apptype.abbrev = "a" * (max_len+1)
    assert !apptype.valid?, "#{apptype.abbrev} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, apptype.errors.on(:abbrev)
    
    #name is exactly maximum length
    apptype.abbrev = "a" * max_len
    assert apptype.valid?, "#{apptype.abbrev} should be just short enough to pass"
  end

  # make sure fullname can't be too short
  def test_fullname_min_length
    apptype = @valid_apptype_1
    min_len = Apptype::FULLNAME_MIN_LENGTH
    
    #fullname too short
    apptype.fullname = "a" * (min_len-1)
    assert !apptype.valid?, "#{apptype.fullname} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    apptype.errors.on(:fullname).each do |errormsg|
      if errormsg != @cantbeblankmsg
        assert_equal correct_error_message, errormsg
      else
        assert_equal @cantbeblankmsg, errormsg
      end
    end
    
    #fullname is exactly minimum length
    apptype.fullname = "a" * min_len
    assert apptype.valid?, "#{apptype.fullname} should be just long enough to pass"
  end
  
  # make sure fullname can't be too long
  def test_fullname_max_length
    apptype = @valid_apptype_1
    max_len = Apptype::FULLNAME_MAX_LENGTH
    
    #fullname too long
    apptype.fullname = "a" * (max_len+1)
    assert !apptype.valid?, "#{apptype.fullname} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, apptype.errors.on(:fullname)
    
    #name is exactly maximum length
    apptype.fullname = "a" * max_len
    assert apptype.valid?, "#{apptype.fullname} should be just short enough to pass"
  end
  
  # make sure translation can't be too long
  def test_translation_max_length
    apptype = @valid_apptype_1
    max_len = Apptype::TRANSLATION_MAX_LENGTH
    
    #translation too long
    apptype.translation = "a" * (max_len+1)
    assert !apptype.valid?, "#{apptype.translation} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, apptype.errors.on(:translation)
    
    #name is exactly maximum length
    apptype.translation = "a" * max_len
    assert apptype.valid?, "#{apptype.translation} should be just short enough to pass"
  end
  
  # insert 2-factor tests (after I figure out how to write the validations, of course)
  # unique: abbrev + country
  # unique: fullname + country
  # country_id == nexthigher.country_id
  # id != nexthigher_id
  
end
