require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
    @error_messages = ActiveRecord::Errors.default_error_messages
  end
  
  # this user should be valid by construction
  def test_user_validity
    assert @valid_user.valid?
  end
  
  # this user should be invalid by construction
  def test_user_invalidity
    assert !@invalid_user.valid?
    attributes = [:handle, :fullname, :email, :password]
    attributes.each do |attribute|
      assert @invalid_user.errors.invalid?(attribute)
    end
  end
  
  # test uniqueness of handle and email
  def test_uniqueness_of_handle_and_email
    user_repeat = User.new(:handle    => @valid_user.handle,
                           :email     => @valid_user.email,
                           :fullname  => @valid_user.fullname,
                           :password  => @valid_user.password)
    assert !user_repeat.valid?
    assert_equal @error_messages[:taken], user_repeat.errors.on(:handle)
    assert_equal @error_messages[:taken], user_repeat.errors.on(:email)
  end
  
  # make sure handle can't be too short
  def test_handle_min_length
    user = @valid_user
    min_len = User::HANDLE_MIN_LENGTH
    
    #handle too short
    user.handle = "a" * (min_len-1)
    assert !user.valid?, "#{user.handle} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    assert_equal correct_error_message, user.errors.on(:handle)
    
    #handle is exactly minimum length
    user.handle = "a" * min_len
    assert user.valid?, "#{user.handle} should be just long enough to pass"
  end
  
  # make sure handle can't be too long
  def test_handle_max_length
    user = @valid_user
    max_len = User::HANDLE_MAX_LENGTH
    
    #handle too long
    user.handle = "a" * (max_len+1)
    assert !user.valid?, "#{user.handle} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, user.errors.on(:handle)
    
    #handle is exactly maximum length
    user.handle = "a" * max_len
    assert user.valid?, "#{user.handle} should be just short enough to pass"
  end

  # make sure fullname can't be too short
  def test_fullname_min_length
    user = @valid_user
    min_len = User::FULLNAME_MIN_LENGTH
    
    #fullnane too short
    user.fullname = "a" * (min_len-1)
    assert !user.valid?, "#{user.fullname} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    assert_equal correct_error_message, user.errors.on(:fullname)
    
    #fullname is exactly minimum length
    user.fullname = "a" * min_len
    assert user.valid?, "#{user.fullname} should be just long enough to pass"
  end
  
  # make sure fullname can't be too long
  def test_fullname_max_length
    user = @valid_user
    max_len = User::FULLNAME_MAX_LENGTH
    
    #fullname too long
    user.fullname = "a" * (max_len+1)
    assert !user.valid?, "#{user.fullname} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, user.errors.on(:fullname)
    
    #fullname is exactly maximum length
    user.fullname = "a" * max_len
    assert user.valid?, "#{user.fullname} should be just short enough to pass"
  end

  # make sure password can't be too short
  def test_password_min_length
    user = @valid_user
    min_len = User::PASSWORD_MIN_LENGTH
    
    #password too short
    user.password = "a" * (min_len-1)
    assert !user.valid?, "#{user.password} should raise a minimum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_short], min_len)
    assert_equal correct_error_message, user.errors.on(:password)
    
    #password is exactly minimum length
    user.password = "a" * min_len
    assert user.valid?, "#{user.password} should be just long enough to pass"
  end
  
  # make sure password can't be too long
  def test_password_max_length
    user = @valid_user
    max_len = User::PASSWORD_MAX_LENGTH
    
    #password too long
    user.password = "a" * (max_len+1)
    assert !user.valid?, "#{user.password} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, user.errors.on(:password)
    
    #password is exactly maximum length
    user.password = "a" * max_len
    assert user.valid?, "#{user.password} should be just short enough to pass"
  end  
  
  # make sure email can't be too long
  def test_email_max_length
    user = @valid_user
    max_len = User::EMAIL_MAX_LENGTH
    
    #construct a valid email that is too long
    user.email = "a" * (max_len - user.email.length + 1) + user.email
    assert !user.valid?, "#{user.email} should raise a maximum length error"
    #format the error message
    correct_error_message = sprintf(@error_messages[:too_long], max_len)
    assert_equal correct_error_message, user.errors.on(:email)
  end
  
# Test REGEXPS

  #test email validator against valid email addresses
  def test_email_with_valid_addresses
    user = @valid_user
    valid_endings = %w{com org mil gov net edu info biz fr jp uk}
    valid_emails = valid_endings.collect do |ending|
      "foo.bar_1-9@baz-quux0.example.#{ending}"
    end
    valid_emails.each do |email|
      user.email = email
      assert user.valid?, "#{email} must be a valid email address"
    end
  end

  #test email validator against invalid email addresses
  def test_email_with_invalid_addresses
    user = @valid_user
    invalid_emails = %w{foobar@example.c foobar@example,com f@com foo@bar..com
                        foobar@example.america foobar.example.com foobar@
                        foo,@example.com foo@aol foo@exa(le.com http://www.xyz.com}
    invalid_emails.each do |email|
      user.email = email
      assert !user.valid?, "#{email} tests as valid but shouldn't be"
      assert_equal "must be a valid email address", user.errors.on(:email)
    end
  end

  #test handle validator against valid examples
  def test_handle_with_valid_examples
    user = @valid_user
    valid_handles = %w{droXXinXXthe john michael web_20 hansensdisease}
    valid_handles.each do |handle|
      user.handle = handle
      assert user.valid?, "#{handle} must be a valid screen name"
    end
  end

  #test handle validator against invalid examples
  def test_handle_with_invalid_examples
    user = @valid_user
    invalid_handles = %w{rails/rocks web2.0 javascript:something "i am me"}
    invalid_handles.each do |handle|
      user.handle = handle
      assert !user.valid?, "#{handle} tests as valid but shouldn't be"
    end
  end
end
