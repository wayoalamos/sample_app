require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "ExampleUser", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should not be empty" do
  	@user.name = "    "
  	assert_not @user.valid?
  end

  test "name should be alphabetic" do
  	@user.name = "@@@7"
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = " "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 21
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "e" * 31 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validation ahould accept valid addresses" do
  	valid_addresses = %w[user@example.com IseR@foo.coM a_Us-er@bduu.ss.org ali+d@baz.co]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower case" do
  	mixed_case_email = "Foor@Example.CoM"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

end
