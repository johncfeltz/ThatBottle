require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < ActiveSupport::TestCase
  fixtures :countries
  
  def setup
    @valid_country = countries(:valid_country)
    @invalid_country = countries(:invalid_country)
    @error_messages = ActiveRecord::Errors.default_error_messages
  end

  # this country should be valid by construction
  def test_country_validity
    assert @valid_country.valid?
  end
  
  # this country should be invalid by construction
  def test_country_invalidity
    assert !@invalid_country.valid?
    attributes = [:name, :isocode_num, :isocode_2let, :isocode_3let]
    attributes.each do |attribute|
      assert @invalid_country.errors.invalid?(attribute)
    end
  end
  
  # test uniqueness of name and 3 isocodes
  def test_uniqueness_of_name_and_isocodes
    country_repeat = Country.new(:name         => @valid_country.name,
                                 :isocode_num  => @valid_country.isocode_num,
                                 :isocode_2let => @valid_country.isocode_2let,
                                 :isocode_3let => @valid_country.isocode_3let)
    assert !country_repeat.valid?
    assert_equal @error_messages[:taken], country_repeat.errors.on(:name)
    assert_equal @error_messages[:taken], country_repeat.errors.on(:isocode_num)
    assert_equal @error_messages[:taken], country_repeat.errors.on(:isocode_2let)
    assert_equal @error_messages[:taken], country_repeat.errors.on(:isocode_3let)
  end
  
  # make sure name can't be too short
  def test_name_min_length
    country = @valid_country
    min_len = Country::NAME_MIN_LENGTH
    
    #name too short
    country.name = "a" * (min_len-1)
    assert !country.valid?, "#{country.name} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    assert_equal correct_error_message, country.errors.on(:name)
    
    #name is exactly minimum length
    country.name = "a" * min_len
    assert country.valid?, "#{country.name} should be just long enough to pass"
  end
  
  # make sure name can't be too long
  def test_name_max_length
    country = @valid_country
    max_len = Country::NAME_MAX_LENGTH
    
    #name too long
    country.name = "a" * (max_len+1)
    assert !country.valid?, "#{country.name} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, country.errors.on(:name)
    
    #name is exactly maximum length
    country.name = "a" * max_len
    assert country.valid?, "#{country.name} should be just short enough to pass"
  end

  # make sure alphabetic ISO codes are correct length
  def test_isocode_2let_length
    country = @valid_country
    len = Country::ISOCODE_2LET_SIZE
    
    #2 letter code too long
    country.isocode_2let = "A" * (len+1)
    assert !country.valid?, "#{country.isocode_2let} should raise a wrong length error"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_2let)
    
    #2 letter code too short
    country.isocode_2let = "A" * (len-1)
    assert !country.valid?, "#{country.isocode_2let} should raise a wrong length error"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_2let)
    
    #2 letter code Goldilocks  --  aka just right
    country.isocode_2let = "A" * len
    assert country.valid?, "#{country.isocode_2let} should be exactly the right length"
  end

  def test_isocode_2let_length
    country = @valid_country
    len = Country::ISOCODE_3LET_SIZE
    
    #3 letter code too long
    country.isocode_3let = "A" * (len+1)
    assert !country.valid?, "#{country.isocode_3let} should raise a wrong length error"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_3let)
    
    #3 letter code too short
    country.isocode_3let = "A" * (len-1)
    assert !country.valid?, "#{country.isocode_3let} should raise a wrong length error"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_3let)
    
    #3 letter code Goldilocks  --  aka just right
    country.isocode_3let = "A" * len
    assert country.valid?, "#{country.isocode_3let} should be exactly the right length"
  end

  # Make sure numeric ISO code is valid
  def test_isocode_num_valid
    country = @valid_country
    len = Country::ISOCODE_NUM_SIZE
    
    #numeric code too long
    country.isocode_num = "4" * (len+1)
    assert !country.valid?, "#{country.isocode_num} should be ruled invalid"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_num)
    
    #numeric code too short
    country.isocode_num = "4" * (len-1)
    assert !country.valid?, "#{country.isocode_num} should be ruled invalid"
    correct_error_message = sprintf(@error_messages[:wrong_length], len)
    assert_equal correct_error_message, country.errors.on(:isocode_num)
    
    #numeric code is correct length, but contains improper characters
    badchars = %w{A a - " "}
    badchars.each do |badchar|
      country.isocode_num = badchar + "5" * (len-1)
      assert !country.valid?, "#{country.isocode_num} tests as valid but shouldn't be"
      assert_equal "is invalid", country.errors.on(:isocode_num)
    end
    
    #numeric code is OK
    country.isocode_num = "4" * len
    assert country.valid?, "#{country.isocode_num} should be exactly the right length"
  end

end
