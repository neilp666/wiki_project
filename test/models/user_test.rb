require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "neil", email: "neil@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
    end

  test "name should be less than 30 chars" do
    @user.name = "a" * 31
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 245 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be in correct format" do
    valid_emails = %w[user@example.com NEIL@gmail.com N.first@yahoo.co.uk john+smith@co.uk.org]
    valid_emails.each do |valids|
     @user.email = valids
     assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "email is invalid" do
    invalid_emails = %w[neil@example neil@example,com neil.name@gmail. neil@bar+foo.com]
    invalid_emails.each do |invalids|
      @user.email = invalids
      assert_not @user.valid?, "#{invalids.inspect} should be invalid"
  end
 end

 test "email should be unique and case insensitive" do
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  @user.save
  assert_not duplicate_user.valid?
 end

 test "email should be lower case before hitting db" do
  mixed_email = "NeiL@Example.com"
  @user.email = mixed_email
  @user.save
  assert_equal mixed_email.downcase, @user.reload.email
 end

end


