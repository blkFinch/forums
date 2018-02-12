require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(screen_name: "ExampleUser", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "screen_name should be present" do 
    @user.screen_name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[user@exampledotcom user_at_foo.org user.name@examp.]
    invalid_addresses.each do |invalid_address |
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "screen_names should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.screen_name = @user.screen_name
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email= @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

end
